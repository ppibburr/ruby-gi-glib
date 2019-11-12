
#       Object.rb
             

# 
module JavaScriptCore
  class Object < JavaScriptCore::Lib::Object

    class << self
      alias :real_new :new
    end  
      
    def self.new *o
      if o[0].is_a? Hash and o[0][:pointer] and o.length == 1
        real_new o[0][:pointer]
      else
        return JavaScriptCore::Object.make(*o)
      end
    end
      

  attr_accessor :context
  
  def self.from_pointer_with_context(ctx,ptr)
    res = self.new(:pointer=>ptr)
    res.context = ctx
    res
  end
    

    # Creates a JavaScript object.
    #
    # @param [JavaScriptCore::Context] ctx The execution context to use.
    # @param [JSClassRef] jsClass The JavaScriptCore::Class to assign to the object. Pass nil to use the default object class.
    # @param [FFI::Pointer] data A void* to set as the object's private data. Pass nil to specify no private data.
    # @return [JavaScriptCore::Object] A JavaScriptCore::Object with the given class and private data.
    def self.make(ctx,jsClass = nil,data = nil)
      res = super(ctx,jsClass,data)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    # Convenience method for creating a JavaScript function with a given callback as its implementation.
    #
    # @param [JavaScriptCore::Context] ctx The execution context to use.
    # @param [JavaScriptCore::String] name A JavaScriptCore::String containing the function's name. This will be used when converting the function to string. Pass nil to create an anonymous function.
    # @param [Proc] callAsFunction The JavaScriptCore::ObjectCallAsFunctionCallback to invoke when the function is called.
    # @return [JavaScriptCore::Object] A JavaScriptCore::Object that is a function. The object's prototype will be the default function prototype.
    def self.make_function_with_callback(ctx,name = nil,&callAsFunction)
      name = JavaScriptCore::String.create_with_utf8cstring(name)
      callAsFunction = JavaScriptCore::CallBack.new(callAsFunction)
      res = super(ctx,name,callAsFunction)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    # Convenience method for creating a JavaScript constructor.
    #
    # @param [JavaScriptCore::Context] ctx The execution context to use.
    # @param [JSClassRef] jsClass A JavaScriptCore::Class that is the class your constructor will assign to the objects its constructs. jsClass will be used to set the constructor's .prototype property, and to evaluate 'instanceof' expressions. Pass nil to use the default object class.
    # @param [FFI::Pointer] callAsConstructor A JavaScriptCore::ObjectCallAsConstructorCallback to invoke when your constructor is used in a 'new' expression. Pass nil to use the default object constructor.
    # @return [JavaScriptCore::Object] A JavaScriptCore::Object that is a constructor. The object's prototype will be the default object prototype.
    def self.make_constructor(ctx,jsClass = nil,callAsConstructor = nil)
      res = super(ctx,jsClass,callAsConstructor)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    # Creates a JavaScript Array object.
    #
    # @param [JavaScriptCore::Context] ctx The execution context to use.
    # @param [Integer] argumentCount An integer count of the number of arguments in arguments.
    # @param [Array] arguments An Array of JavaScriptCore::Value's of data to populate the Array with. Pass nil if argumentCount is 0.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [JavaScriptCore::Object] A JavaScriptCore::Object that is an Array.
    def self.make_array(ctx,argumentCount,arguments,exception = nil)
      res = super(ctx,argumentCount,arguments,exception)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    # Creates a function with a given script as its body.
    #
    # @param [JavaScriptCore::Context] ctx The execution context to use.
    # @param [JavaScriptCore::String] name A JavaScriptCore::String containing the function's name. This will be used when converting the function to string. Pass nil to create an anonymous function.
    # @param [Integer] parameterCount An integer count of the number of parameter names in parameterNames.
    # @param [Array] parameterNames An Array of JavaScriptCore::String's containing the names of the function's parameters. Pass nil if parameterCount is 0.
    # @param [JavaScriptCore::String] body A JavaScriptCore::String containing the script to use as the function's body.
    # @param [JavaScriptCore::String] sourceURL A JavaScriptCore::String containing a URL for the script's source file. This is only used when reporting exceptions. Pass nil if you do not care to include source file information in exceptions.
    # @param [Integer] startingLineNumber An integer value specifying the script's starting line number in the file located at sourceURL. This is only used when reporting exceptions.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store a syntax error exception, if any. Pass nil if you do not care to store a syntax error exception.
    # @return [JavaScriptCore::Object] A JavaScriptCore::Object that is a function, or NULL if either body or parameterNames contains a syntax error. The object's prototype will be the default function prototype.
    def self.make_function(ctx,name,parameterCount,parameterNames,body,sourceURL,startingLineNumber,exception = nil)
      name = JavaScriptCore::String.create_with_utf8cstring(name)
      body = JavaScriptCore::String.create_with_utf8cstring(body)
      sourceURL = JavaScriptCore::String.create_with_utf8cstring(sourceURL)
      parameterNames = JavaScriptCore.create_pointer_of_array(JavaScriptCore::String,parameterNames)
      res = super(ctx,name,parameterCount,parameterNames,body,sourceURL,startingLineNumber,exception)
      wrap = self.new(:pointer=>res)
      wrap.context = ctx
      return wrap
    end

    # Gets an object's prototype.
    #
    # @return [JavaScriptCore::Value] A JavaScriptCore::Value that is the object's prototype.
    def get_prototype()
      res = super(context,self)

    
      val_ref = JavaScriptCore::Value.from_pointer_with_context(context,res)
      ret = val_ref.to_ruby
      if ret.is_a?(JavaScriptCore::Value)
        return JavaScriptCore::BaseObject.is_wrapped?(res) || check_use(ret) || is_self(ret) || ret
      else
        return JavaScriptCore::BaseObject.is_wrapped?(res) || check_use(ret) || ret
      end
    
        
    end

    # Sets an object's prototype.
    #
    # @param [JavaScriptCore::Value] value A JavaScriptCore::Value to set as the object's prototype.
    def set_prototype(value)
      value = JavaScriptCore::Value.from_ruby(context,value)
      res = super(context,self,value)
      return res
    end

    # Tests whether an object has a given property.
    #
    # @param [JavaScriptCore::String] propertyName A JavaScriptCore::String containing the property's name.
    # @return [boolean] true if the object has a property whose name matches propertyName, otherwise false.
    def has_property(propertyName)
      propertyName = JavaScriptCore::String.create_with_utf8cstring(propertyName)
      res = super(context,self,propertyName)
      return res
    end

    # Gets a property from an object.
    #
    # @param [JavaScriptCore::String] propertyName A JavaScriptCore::String containing the property's name.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [JavaScriptCore::Value] The property's value if object has the property, otherwise the undefined value.
    def get_property(propertyName,exception = nil)
      propertyName = JavaScriptCore::String.create_with_utf8cstring(propertyName)
      res = super(context,self,propertyName,exception)

    
      val_ref = JavaScriptCore::Value.from_pointer_with_context(context,res)
      ret = val_ref.to_ruby
      if ret.is_a?(JavaScriptCore::Value)
        return JavaScriptCore::BaseObject.is_wrapped?(res) || check_use(ret) || is_self(ret) || ret
      else
        return JavaScriptCore::BaseObject.is_wrapped?(res) || check_use(ret) || ret
      end
    
        
    end

    # Sets a property on an object.
    #
    # @param [JavaScriptCore::String] propertyName A JavaScriptCore::String containing the property's name.
    # @param [JavaScriptCore::Value] value A JavaScriptCore::Value to use as the property's value.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @param [FFI::Pointer] attributes A logically ORed set of JSPropertyAttributes to give to the property.
    def set_property(propertyName,value,attributes = nil,exception = nil)
      propertyName = JavaScriptCore::String.create_with_utf8cstring(propertyName)
      value = JavaScriptCore::Value.from_ruby(context,value)
      res = super(context,self,propertyName,value,attributes,exception)
      return res
    end

    # Deletes a property from an object.
    #
    # @param [JavaScriptCore::String] propertyName A JavaScriptCore::String containing the property's name.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [boolean] true if the delete operation succeeds, otherwise false (for example, if the property has the kJSPropertyAttributeDontDelete attribute set).
    def delete_property(propertyName,exception = nil)
      propertyName = JavaScriptCore::String.create_with_utf8cstring(propertyName)
      res = super(context,self,propertyName,exception)
      return res
    end

    # Gets a property from an object by numeric index.
    #
    # @param [Integer] propertyIndex An integer value that is the property's name.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [JavaScriptCore::Value] The property's value if object has the property, otherwise the undefined value.
    def get_property_at_index(propertyIndex,exception = nil)
      res = super(context,self,propertyIndex,exception)

    
      val_ref = JavaScriptCore::Value.from_pointer_with_context(context,res)
      ret = val_ref.to_ruby
      if ret.is_a?(JavaScriptCore::Value)
        return JavaScriptCore::BaseObject.is_wrapped?(res) || check_use(ret) || is_self(ret) || ret
      else
        return JavaScriptCore::BaseObject.is_wrapped?(res) || check_use(ret) || ret
      end
    
        
    end

    # Sets a property on an object by numeric index.
    #
    # @param [Integer] propertyIndex The property's name as a number.
    # @param [JavaScriptCore::Value] value A JavaScriptCore::Value to use as the property's value.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    def set_property_at_index(propertyIndex,value,exception = nil)
      value = JavaScriptCore::Value.from_ruby(context,value)
      res = super(context,self,propertyIndex,value,exception)
      return res
    end

    # Gets an object's private data.
    #
    # @return [FFI::Pointer] A void* that is the object's private data, if the object has private data, otherwise NULL.
    def get_private()
      res = super(self)
      return res
    end

    # Sets a pointer to private data on an object.
    #
    # @param [FFI::Pointer] data A void* to set as the object's private data.
    # @return [boolean] true if object can store private data, otherwise false.
    def set_private(data)
      res = super(self,data)
      return res
    end

    # Tests whether an object can be called as a function.
    #
    # @return [boolean] true if the object can be called as a function, otherwise false.
    def is_function()
      res = super(context,self)
      return res
    end

    # @note A convienience method is at JavaScriptCore::Object#call
    # @see Object#call
    # Calls an object as a function.
    #
    # @param [JavaScriptCore::Object] thisObject The object to use as "this," or nil to use the global object as "this."
    # @param [Array] arguments An Array of JavaScriptCore::Value's of arguments to pass to the function. Pass nil if argumentCount is 0.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [JavaScriptCore::Value] The JavaScriptCore::Value that results from calling object as a function, or NULL if an exception is thrown or object is not a function.
    def call_as_function(thisObject = nil,argumentCount = 0,arguments = nil,exception = nil)
      thisObject = JavaScriptCore::Object.from_ruby(context,thisObject)
      arguments = JavaScriptCore.create_pointer_of_array(JavaScriptCore::Value,arguments,context)
      res = super(context,self,thisObject,argumentCount,arguments,exception)

    
      val_ref = JavaScriptCore::Value.from_pointer_with_context(context,res)
      ret = val_ref.to_ruby
      if ret.is_a?(JavaScriptCore::Value)
        return JavaScriptCore::BaseObject.is_wrapped?(res) || check_use(ret) || is_self(ret) || ret
      else
        return JavaScriptCore::BaseObject.is_wrapped?(res) || check_use(ret) || ret
      end
    
        
    end

    # Tests whether an object can be called as a constructor.
    #
    # @return [boolean] true if the object can be called as a constructor, otherwise false.
    def is_constructor()
      res = super(context,self)
      return res
    end

    # Calls an object as a constructor.
    #
    # @param [Array] arguments An Array of JavaScriptCore::Value's of arguments to pass to the constructor. Pass nil if argumentCount is 0.
    # @param [FFI::Pointer] exception A pointer to a JavaScriptCore::ValueRef in which to store an exception, if any. Pass nil if you do not care to store an exception.
    # @return [JavaScriptCore::Object] The JavaScriptCore::Object that results from calling object as a constructor, or NULL if an exception is thrown or object is not a constructor.
    def call_as_constructor(argumentCount = 0,arguments = nil,exception = nil)
      arguments = JavaScriptCore.create_pointer_of_array(JavaScriptCore::Value,arguments,context)
      res = super(context,self,argumentCount,arguments,exception)
      return JavaScriptCore::BaseObject.is_wrapped?(res) || JavaScriptCore::Object.from_pointer_with_context(context,res)
    end

    # Gets the names of an object's enumerable properties.
    #
    # @return [JavaScriptCore::PropertyNameArray] A JavaScriptCore::PropertyNameArray containing the names object's enumerable properties. Ownership follows the Create Rule.
    def copy_property_names()
      res = super(context,self)
      return JavaScriptCore::PropertyNameArray.new(res)
    end
  end
end
