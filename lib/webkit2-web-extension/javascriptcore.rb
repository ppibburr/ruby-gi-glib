require 'javascriptcore'

WebKit2WebExtension::WebPage;

module WebKit2WebExtension
  module FFILib
    extend FFI::Library
    
    ffi_lib "webkit2gtk-4.0"
    
    attach_function :webkit_frame_get_javascript_global_context, [:pointer], :pointer
  end
  
  class Frame
    def javascript_global_context
      ptr = FFILib.webkit_frame_get_javascript_global_context ffi_pointer
      o = JavaScriptCore::GlobalContext.new pointer: ptr

      o
    end;
  
    def execute s, &b    
      res = JavaScriptCore.execute_script(javascript_global_context, s)
      b.call res if res
      res
    end
  end
end
