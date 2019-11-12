module ExportFFI
  def to_ffi
    inspect =~ /ptr\=(.*)\>/
    FFI::Pointer.new($1.strip.to_i(16))
  end
end
