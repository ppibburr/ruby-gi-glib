require 'glib'
require 'gio2'

module Gio
  l          = GObjectIntrospection::Loader.new(self)
  repository = GObjectIntrospection::Repository.default

  repository.require("Gio", "2.0")

  l.send :load_info,repository.find("Gio", "File")
  
  ApplicationCommandLine  
  
  class Gio::ApplicationCommandLine
    module Lib 
      extend FFI::Library
      ffi_lib "gio-2.0"
      attach_function :g_application_command_line_print,[:pointer,:string],:void
      attach_function :g_application_command_line_printerr,[:pointer,:string],:void      
    end
    
    # FIXME: does not get captured in `` 
    # @return IO invoking proccess stdin and stdout
    def io
      @io ||= IO.new(@fd=stdin.fd)    
    end
    
    # Print to invoking proccess stdout
    def print *s
      s.each do |_|
        Lib.g_application_command_line_print self.ffi_pointer, _.to_s+"\n"
      end
    end
    
    # Print to invoking proccess stderr
    def printerr *s
      s.each do |_|
        Lib.g_application_command_line_printerr self.ffi_pointer, _.to_s+"\n"
      end
    end    
  end

  Application
  class Application
    class Options
      attr_reader :application
      def initialize application
        @application = application
        @map         = {}
      end
      
      # Add main option entry to application
      #
      # @param String +long+  the option name
      # @param String +short+ the option short-name
      # @param String +desc+ the option description
      # @param Symbol|NilClass +type+ the type of argument for option
      def on long,short,desc,type=nil, &b
        t = gt = (type || :none)
        ((gt = "#{t[0]}_array") && t=t[0]) if type.is_a?(::Array)
        gt = :"#{gt.upcase}"
        
        @map[long] = {block: b, type: gt}

        application.add_main_option(long,short,GLib::OptionFlags::NONE,GLib::OptionArg.const_get(gt), desc, type ? t.to_s.upcase : nil) 
      end
    
      def parse dict
        opts= {}
        
        @map.each_pair do |k,v|
          v=opts[k]=dict.lookup_value(k, GLib::VariantType.const_get(@map[k][:type]))
          @map[k][:block].call v if @map[k][:block]
        end
        
        opts
      end
    end

    # Simplified Option Management
    # @return Options
    def options
      @options ||= Application::Options.new(self)
    end 

    # Overide to handle options locally
    #
    # @param Hash +opts+ The options and values passed
    #
    # @return Integer (-1 to continue, 0 or greater to exit, Default: -1)
    def local_options opts
      -1
    end
    
    # Override to handle options on the primary instance
    # calls GLib::Object#unref on +cmdline+ when done
    #
    # @param Hash +opts+ The options and values passed
    # @param Gio::ApplicationCommandLine +cmdline+
    #
    # @return Integer (Default: 0 The exit status for +cmdline+)
    def remote_options opts, cmdline, unref_cmdline=true
      args = cmdline.arguments[1..-1].map do |a|
        cmdline.create_file_for_arg(a).uri
      end
      
      args.empty? ? activate : open_files(args)
      
      unref_cmdline ? cmdline.unref : nil
      
      -1
    end
    
    # Override to implement file opening from ARGV after options are parsed out
    def open_files *o
      activate
    end
    
    class << self
      def new *o,&b
        ins = super
        ins.instance_exec do
          signal_connect "handle-local-options" do |_,dict|
            local_options(options.parse(dict))
          end
      
          signal_connect "command-line" do |_,c|
            result = remote_options options.parse(c.options_dict), c
            1
          end
        end
        ins
      end
    end
  end
end
