require 'webkit2-gtk'

WebKit2Gtk::WebView; Gtk::Widget;
require File.expand_path(File.join(File.dirname(__FILE__), "patch_gobject"))

module WebKit2Gtk
  module FFILib
    extend FFI::Library
    
    ffi_lib "webkit2gtk-4.0"
    
    attach_function :webkit_web_view_get_javascript_global_context, [:pointer], :pointer
    attach_function :webkit_javascript_result_get_global_context, [:pointer], :pointer    
    attach_function :webkit_javascript_result_get_value, [:pointer], :pointer

  end
  
  class JavascriptResult
    include ExportFFI
    def value
      ptr = FFILib.webkit_javascript_result_get_value(to_ffi)
      JavaScriptCore::Value.from_pointer_with_context global_context, ptr
    end
    
    def global_context
      ptr = FFILib.webkit_javascript_result_get_global_context to_ffi
      o = JavaScriptCore::GlobalContext.new pointer: ptr
      o
    end
  end
  
  class WebView
    def javascript_global_context
      ptr = FFILib.webkit_web_view_get_javascript_global_context to_ffi
      o = JavaScriptCore::GlobalContext.new pointer: ptr
      o
    end;
  
    def execute s, &b    
      res = true
      
      run_javascript(s) do |_,r|
        begin
          jr  = run_javascript_finish(r)
          res = jr.value.to_ruby
          yield(res, jr, jr.global_context) if block_given?
        rescue => e
          yield nil,nil,nil,e if block_given?
        end
      end
      
      !!res
    end
  end
end
