$: << File.expand_path(File.dirname(__FILE__))

require 'glib'
require 'cairo-gobject'
require 'gdk'
require 'gio'

require 'gtk3/loader'

module Gtk;
  @l=Loader.new(self,[])
  
  class << @l;attr_reader :base_module;end
  
  r=GObjectIntrospection::Repository.default
  r.require("Gtk","3.0")
  
  [:main, :main_quit].each do |q|
    i = r.find("Gtk",q.to_s)
    @l.send :load_info, i
  end

  def self.init
    class << self
      remove_method :init
    end
    init_check = GObjectIntrospection::Repository.default.find("Gtk", "init_check")
    arguments = [
      [$0] + ARGV,
    ]
    succeeded, argv = init_check.invoke(arguments)
    ARGV.replace(argv[1..-1])
    succeeded
  end
  
  def self.method_missing m,*o,&b
    init if respond_to? :init
    @l.send :load_function_info, GObjectIntrospection::Repository.default.find("Gtk", "gtk_#{m}")
    super unless respond_to?(m)
    send m,*o,&b
  end
  
  def self.const_missing c
    init if respond_to? :init
    info = GObjectIntrospection::Repository.default.find("Gtk","#{c}")
    if info.respond_to?(:parent)
      if info.parent.namespace == "Gtk"
        const_missing info.parent.name.to_sym
      end
    end
    super if !info
    
    @l.send :load_info, info
    
    return Gtk.const_get(c)
  rescue => e
    begin
      print_err e
    rescue
      puts e
      puts e.backtrace.join("\n")
      Gtk.main_quit
    end
    Gtk.main_quit
  end       
end
  

