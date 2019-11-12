require 'glib2'
require 'gobject-introspection'
require 'ffi'

module GLib
  GLib::VariantType::INT = GLib::VariantType::INT32

  l          = GObjectIntrospection::Loader.new(self)
  repository = GObjectIntrospection::Repository.default

  repository.require("GLib", "2.0")

  l.send :load_info,repository.find("GLib", "VariantDict")
  l.send :load_info,repository.find("GLib", "OptionFlags")
  l.send :load_info,repository.find("GLib", "OptionArg")  

  module CPointer
    def c_pointer
      @_insp ||= if is_a?(Boxed)
        GLib::Boxed.instance_method(:inspect)
      else
        GLib::Object.instance_method(:inspect)
      end 
    
      addr = @_insp.bind(self).call().scan(/ptr\=(.*)\>/)[0][0].to_i(16)
    end
    
    def ffi_pointer
      FFI::Pointer.new(c_pointer())
    end
    
    def self.manage_ptr ptr
      GObjectIntrospection::Loader.instantiate_gobject_pointer(ptr.address)
    end   
  end

  self::Object
  class self::Object
    class Lib
      extend FFI::Library
      ffi_lib "gobject-2.0"
      attach_function :g_object_ref, [:pointer],:void
    end
    
    include CPointer   
    
    def ref
      Lib.g_object_ref(ffi_pointer)
    end
  end
  
  Boxed
  class Boxed
    include CPointer
  end
end
