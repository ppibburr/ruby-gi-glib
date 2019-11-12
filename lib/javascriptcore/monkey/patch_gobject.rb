require File.join(File.dirname(__FILE__),'export_ffi')

GLib::Object
class GLib::Object
  include ExportFFI
end
