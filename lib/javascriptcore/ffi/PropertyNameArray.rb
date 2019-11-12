
#       PropertyNameArray.rb
             

# 
module JavaScriptCore
  module Lib
    class PropertyNameArray < JavaScriptCore::BaseObject

      # Retains a JavaScript property name array.
      #
      # @param [:JSPropertyNameArrayRef] array The JSPropertyNameArray to retain.
      # @return A JSPropertyNameArray that is the same as array.
      def retain(array)
        JavaScriptCore::Lib.JSPropertyNameArrayRetain(array)
      end

      # Releases a JavaScript property name array.
      #
      # @param [:JSPropertyNameArrayRef] array The JSPropetyNameArray to release.
      def release(array)
        JavaScriptCore::Lib.JSPropertyNameArrayRelease(array)
      end

      # Gets a count of the number of items in a JavaScript property name array.
      #
      # @param [:JSPropertyNameArrayRef] array The array from which to retrieve the count.
      # @return An integer count of the number of names in array.
      def get_count(array)
        JavaScriptCore::Lib.JSPropertyNameArrayGetCount(array)
      end

      # Gets a property name at a given index in a JavaScript property name array.
      #
      # @param [:JSPropertyNameArrayRef] array The array from which to retrieve the property name.
      # @param [:size_t] index The index of the property name to retrieve.
      # @return A JSStringRef containing the property name.
      def get_name_at_index(array,index)
        JavaScriptCore::Lib.JSPropertyNameArrayGetNameAtIndex(array,index)
      end
    end
  end
end
