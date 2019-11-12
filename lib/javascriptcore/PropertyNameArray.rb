
#       PropertyNameArray.rb
             

# 
module JavaScriptCore
  class PropertyNameArray < JavaScriptCore::Lib::PropertyNameArray

    # Retains a JavaScript property name array.
    #
    # @return [JavaScriptCore::PropertyNameArray] A JavaScriptCore::PropertyNameArray that is the same as array.
    def retain()
      res = super(self)
      return JavaScriptCore::PropertyNameArray.new(res)
    end

    # Releases a JavaScript property name array.
    #
    def release()
      res = super(self)
      return res
    end

    # Gets a count of the number of items in a JavaScript property name array.
    #
    # @return [Integer] An integer count of the number of names in array.
    def get_count()
      res = super(self)
      return res
    end

    # Gets a property name at a given index in a JavaScript property name array.
    #
    # @param [Integer] index The index of the property name to retrieve.
    # @return [JavaScriptCore::String] A JavaScriptCore::StringRef containing the property name.
    def get_name_at_index(index)
      res = super(self,index)
      return JavaScriptCore.read_string(res)
    end
  end
end
