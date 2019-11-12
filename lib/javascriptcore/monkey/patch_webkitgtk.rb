require 'webkit-gtk'

WebKitGtk::WebView; Gtk::Widget;
require File.expand_path(File.join(File.dirname(__FILE__), "patch_gobject"))

module WebKit2Gtk
  module FFILib
    extend FFI::Library
    
    ffi_lib "webkitgtk-3.0"
    
    attach_function :webkit_web_frame_get_global_context, [:pointer], :pointer
  end
  
  class WebFrame
    def get_global_context
      ptr = FFILib.webkit_web_frame_get_global_context to_ffi
      o = JavaScriptCore::GlobalContext.new pointer: ptr
      p ptr,o
      o
    end;
  
    def execute s, &b    
      r = JavaScriptCore.execute_script(javascript_global_context, s)
      b.call r if b
      r
    end
  end
end
