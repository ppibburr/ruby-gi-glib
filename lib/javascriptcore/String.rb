
#       String.rb
             

# 
module JavaScriptCore
  class String < JavaScriptCore::Lib::String

    class << self
      alias :real_new :new
    end  
      
    def self.new *o
      if o[0].is_a? Hash and o[0][:pointer] and o.length == 1
        real_new o[0][:pointer]
      else
        return JavaScriptCore::String.create_with_utf8cstring(*o)
      end
    end
      

    #         Creates a JavaScript string from a buffer of Unicode characters.
    #
    # @param [FFI::Pointer] chars      The buffer of Unicode characters to copy into the new JavaScriptCore::String.
    # @param [Integer] numChars   The number of characters to copy from the buffer pointed to by chars.
    # @return [JavaScriptCore::String]           A JavaScriptCore::String containing chars. Ownership follows the Create Rule.
    def self.create_with_characters(chars,numChars)
      res = super(chars,numChars)
      wrap = self.new(:pointer=>res)
      return wrap
    end

    #         Creates a JavaScript string from a null-terminated UTF8 string.
    #
    # @param [FFI::Pointer] string     The null-terminated UTF8 string to copy into the new JavaScriptCore::String.
    # @return [JavaScriptCore::String]           A JavaScriptCore::String containing string. Ownership follows the Create Rule.
    def self.create_with_utf8cstring(string)
      res = super(string)
      wrap = self.new(:pointer=>res)
      return wrap
    end

    #         Retains a JavaScript string.
    #
    # @return [JavaScriptCore::String]           A JavaScriptCore::String that is the same as string.
    def retain()
      res = super(self)
      return JavaScriptCore.read_string(res)
    end

    #         Releases a JavaScript string.
    #
    def release()
      res = super(self)
      return res
    end

    #         Returns the number of Unicode characters in a JavaScript string.
    #
    # @return [Integer]           The number of Unicode characters stored in string.
    def get_length()
      res = super(self)
      return res
    end


    def get_characters_ptr()
      res = super(self)
      return res
    end

    # Returns the maximum number of bytes a JavaScript string will
    #
    # @return [Integer] The maximum number of bytes that could be required to convert string into a
    def get_maximum_utf8cstring_size()
      res = super(self)
      return res
    end

    # Converts a JavaScript string into a null-terminated UTF8 string,
    #
    # @param [FFI::Pointer] buffer The destination byte buffer into which to copy a null-terminated
    # @param [Integer] bufferSize The size of the external buffer in bytes.
    # @return [Integer] The number of bytes written into buffer (including the null-terminator byte).
    def get_utf8cstring(buffer,bufferSize)
      res = super(self,buffer,bufferSize)
      return res
    end
    
    def to_s
      size = get_length
      get_utf8cstring a=FFI::MemoryPointer.new(:pointer,size+1),size+1
      a.read_string
    end

    #     Tests whether two JavaScript strings match.
    #
    # @param [JavaScriptCore::String] b      The second JavaScriptCore::String to test.
    # @return [boolean]       true if the two strings match, otherwise false.
    def is_equal(b)
      b = JavaScriptCore::String.create_with_utf8cstring(b)
      res = super(self,b)
      return res
    end

    #     Tests whether a JavaScript string matches a null-terminated UTF8 string.
    #
    # @param [FFI::Pointer] b      The null-terminated UTF8 string to test.
    # @return [boolean]       true if the two strings match, otherwise false.
    def is_equal_to_utf8cstring(b)
      res = super(self,b)
      return res
    end
  end
end
