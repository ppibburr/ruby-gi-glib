
#       Value.rb
             

# 
module JavaScriptCore
  class Value < JavaScriptCore::Lib::Value

    class << self
      alias :real_new :new
    end  
      
    def self.new *o
      if o[0].is_a? Hash and o[0][:pointer] and o.length == 1
        real_new o[0][:pointer]
      else
        return JavaScriptCore::Value.make_undefined(*o)
      end
    end
      

  attr_accessor :context
  
  def self.from_pointer_with_context(ctx,ptr)
    res = self.new(:pointer=>ptr)
    res.context = ctx
    res
  end
    

    #       Creates a JavaScript value of the undefined type.
    #
    # @param [JavaScriptCore::Context] ctx  The execution context to use.
    # @return [JavaScriptCore::Value]         The unique undefined value.
    def self.make_undefined(ctx)
      res = super(ctx)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    #       Creates a JavaScript value of the null type.
    #
    # @param [JavaScriptCore::Context] ctx  The execution context to use.
    # @return [JavaScriptCore::Value]         The unique null value.
    def self.make_null(ctx)
      res = super(ctx)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    #       Creates a JavaScript value of the boolean type.
    #
    # @param [JavaScriptCore::Context] ctx  The execution context to use.
    # @param [boolean] boolean  The bool to assign to the newly created JavaScriptCore::Value.
    # @return [JavaScriptCore::Value]         A JavaScriptCore::Value of the boolean type, representing the value of boolean.
    def self.make_boolean(ctx,boolean)
      res = super(ctx,boolean)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    #       Creates a JavaScript value of the number type.
    #
    # @param [JavaScriptCore::Context] ctx  The execution context to use.
    # @param [Float] number   The double to assign to the newly created JavaScriptCore::Value.
    # @return [JavaScriptCore::Value]         A JavaScriptCore::Value of the number type, representing the value of number.
    def self.make_number(ctx,number)
      res = super(ctx,number)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    #       Creates a JavaScript value of the string type.
    #
    # @param [JavaScriptCore::Context] ctx  The execution context to use.
    # @param [JavaScriptCore::String] string   The JavaScriptCore::String to assign to the newly created JavaScriptCore::Value. The
    # @return [JavaScriptCore::Value]         A JavaScriptCore::Value of the string type, representing the value of string.
    def self.make_string(ctx,string)
      string = JavaScriptCore::String.create_with_utf8cstring(string)
      res = super(ctx,string)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    #       Returns a JavaScript value's type.
    #
    # @return [FFI::Pointer]         A value of type JSType that identifies value's type.
    def get_type()
      res = super(context,self)
      return res
    end

    #       Tests whether a JavaScript value's type is the undefined type.
    #
    # @return [boolean]         true if value's type is the undefined type, otherwise false.
    def is_undefined()
      res = super(context,self)
      return res
    end

    #       Tests whether a JavaScript value's type is the null type.
    #
    # @return [boolean]         true if value's type is the null type, otherwise false.
    def is_null()
      res = super(context,self)
      return res
    end

    #       Tests whether a JavaScript value's type is the boolean type.
    #
    # @return [boolean]         true if value's type is the boolean type, otherwise false.
    def is_boolean()
      res = super(context,self)
      return res
    end

    #       Tests whether a JavaScript value's type is the number type.
    #
    # @return [boolean]         true if value's type is the number type, otherwise false.
    def is_number()
      res = super(context,self)
      return res
    end

    #       Tests whether a JavaScript value's type is the string type.
    #
    # @return [boolean]         true if value's type is the string type, otherwise false.
    def is_string()
      res = super(context,self)
      return res
    end

    #       Tests whether a JavaScript value's type is the object type.
    #
    # @return [boolean]         true if value's type is the object type, otherwise false.
    def is_object()
      res = super(context,self)
      return res
    end

    # Tests whether a JavaScript value is an object with a given class in its class chain.
    #
    # @param [JSClassRef] jsClass The JavaScriptCore::Class to test against.
    # @return [boolean] true if value is an object and has jsClass in its class chain, otherwise false.
    def is_object_of_class(jsClass)
      res = super(context,self,jsClass)
      return res
    end

    # Tests whether two JavaScript values are equal, as compared by the JS == operator.
    #
    # @param [JavaScriptCore::Value] b The second value to test.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [boolean] true if the two values are equal, false if they are not equal or an exception is thrown.
    def is_equal(b,exception = nil)
      b = JavaScriptCore::Value.from_ruby(context,b)
      res = super(context,self,b,exception)
      return res
    end

    #       Tests whether two JavaScript values are strict equal, as compared by the JS === operator.
    #
    # @param [JavaScriptCore::Value] b        The second value to test.
    # @return [boolean]         true if the two values are strict equal, otherwise false.
    def is_strict_equal(b)
      b = JavaScriptCore::Value.from_ruby(context,b)
      res = super(context,self,b)
      return res
    end

    # Tests whether a JavaScript value is an object constructed by a given constructor, as compared by the JS instanceof operator.
    #
    # @param [JavaScriptCore::Object] constructor The constructor to test against.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [boolean] true if value is an object constructed by constructor, as compared by the JS instanceof operator, otherwise false.
    def is_instance_of_constructor(constructor,exception = nil)
      constructor = JavaScriptCore::Object.from_ruby(context,constructor)
      res = super(context,self,constructor,exception)
      return res
    end

    #       Converts a JavaScript value to boolean and returns the resulting boolean.
    #
    # @return [boolean]         The boolean result of conversion.
    def to_boolean()
      res = super(context,self)
      return res
    end

    #       Converts a JavaScript value to number and returns the resulting number.
    #
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [Float]         The numeric result of conversion, or NaN if an exception is thrown.
    def to_number(exception = nil)
      res = super(context,self,exception)
      return res
    end

    #       Converts a JavaScript value to string and copies the result into a JavaScript string.
    #
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [JavaScriptCore::String]         A JavaScriptCore::String with the result of conversion, or NULL if an exception is thrown. Ownership follows the Create Rule.
    def to_string_copy(exception = nil)
      res = super(context,self,exception)
      return JavaScriptCore.read_string(res)
    end

    # Converts a JavaScript value to object and returns the resulting object.
    #
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [JavaScriptCore::Object]         The JavaScriptCore::Object result of conversion, or NULL if an exception is thrown.
    def to_object(exception = nil)
      res = super(context,self,exception)
      return JavaScriptCore::BaseObject.is_wrapped?(res) || JavaScriptCore::Object.from_pointer_with_context(context,res)
    end

    # Protects a JavaScript value from garbage collection.
    #
    def protect()
      res = super(context,self)
      return res
    end

    #       Unprotects a JavaScript value from garbage collection.
    #
    def unprotect()
      res = super(context,self)
      return res
    end
  end
end
