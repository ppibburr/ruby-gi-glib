
#       String.rb
             

# 
module JavaScriptCore
  module Lib
    class String < JavaScriptCore::BaseObject

      #         Creates a JavaScript string from a buffer of Unicode characters.
      #
      # @param [:pointer] chars      The buffer of Unicode characters to copy into the new JSString.
      # @param [:size_t] numChars   The number of characters to copy from the buffer pointed to by chars.
      # @return           A JSString containing chars. Ownership follows the Create Rule.
      def self.create_with_characters(chars,numChars)
        JavaScriptCore::Lib.JSStringCreateWithCharacters(chars,numChars)
      end

      #         Creates a JavaScript string from a null-terminated UTF8 string.
      #
      # @param [:pointer] string     The null-terminated UTF8 string to copy into the new JSString.
      # @return           A JSString containing string. Ownership follows the Create Rule.
      def self.create_with_utf8cstring(string)
        JavaScriptCore::Lib.JSStringCreateWithUTF8CString(string)
      end

      #         Retains a JavaScript string.
      #
      # @param [:JSStringRef] string     The JSString to retain.
      # @return           A JSString that is the same as string.
      def retain(string)
        JavaScriptCore::Lib.JSStringRetain(string)
      end

      #         Releases a JavaScript string.
      #
      # @param [:JSStringRef] string     The JSString to release.
      def release(string)
        JavaScriptCore::Lib.JSStringRelease(string)
      end

      #         Returns the number of Unicode characters in a JavaScript string.
      #
      # @param [:JSStringRef] string     The JSString whose length (in Unicode characters) you want to know.
      # @return           The number of Unicode characters stored in string.
      def get_length(string)
        JavaScriptCore::Lib.JSStringGetLength(string)
      end


      def get_characters_ptr(string)
        JavaScriptCore::Lib.JSStringGetCharactersPtr(string)
      end

      # Returns the maximum number of bytes a JavaScript string will
      #
      # @param [:JSStringRef] string The JSString whose maximum converted size (in bytes) you
      # @return The maximum number of bytes that could be required to convert string into a
      def get_maximum_utf8cstring_size(string)
        JavaScriptCore::Lib.JSStringGetMaximumUTF8CStringSize(string)
      end

      # Converts a JavaScript string into a null-terminated UTF8 string,
      #
      # @param [:JSStringRef] string The source JSString.
      # @param [:pointer] buffer The destination byte buffer into which to copy a null-terminated
      # @param [:size_t] bufferSize The size of the external buffer in bytes.
      # @return The number of bytes written into buffer (including the null-terminator byte).
      def get_utf8cstring(string,buffer,bufferSize)
        JavaScriptCore::Lib.JSStringGetUTF8CString(string,buffer,bufferSize)
      end

      #     Tests whether two JavaScript strings match.
      #
      # @param [:JSStringRef] a      The first JSString to test.
      # @param [:JSStringRef] b      The second JSString to test.
      # @return       true if the two strings match, otherwise false.
      def is_equal(a,b)
        JavaScriptCore::Lib.JSStringIsEqual(a,b)
      end

      #     Tests whether a JavaScript string matches a null-terminated UTF8 string.
      #
      # @param [:JSStringRef] a      The JSString to test.
      # @param [:pointer] b      The null-terminated UTF8 string to test.
      # @return       true if the two strings match, otherwise false.
      def is_equal_to_utf8cstring(a,b)
        JavaScriptCore::Lib.JSStringIsEqualToUTF8CString(a,b)
      end
    end
  end
end
