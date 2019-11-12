
#       GlobalContext.rb
             

# 
module JavaScriptCore
  class GlobalContext < JavaScriptCore::Lib::GlobalContext
    include JavaScriptCore::Context

    class << self
      alias :real_new :new
    end  
      
    def self.new *o
      if o[0].is_a? Hash and o[0][:pointer] and o.length == 1
        c = real_new o[0][:pointer]
      else
        c = JavaScriptCore::GlobalContext.create(*o)
      end
      
      unless (go=c.get_global_object)[m=:_rb_method_delegate_].is_a?(JavaScriptCore::Object)
        go[m] = {}
        go[m][:get] = $_rb_method_delegate_
      end
      
      c
    end
      

    # Creates a global JavaScript execution context.
    #
    # @param [JSClassRef] globalObjectClass The class to use when creating the global object. Pass
    # @return [JavaScriptCore::GlobalContext] A JavaScriptCore::GlobalContext with a global object of class globalObjectClass.
    def self.create(globalObjectClass)
      res = super(globalObjectClass)
      wrap = self.new(:pointer=>res)
      return wrap
    end

    # Creates a global JavaScript execution context in the context group provided.
    #
    # @param [JSClassRef] globalObjectClass The class to use when creating the global object. Pass
    # @param [JavaScriptCore::ContextGroup] group The context group to use. The created global context retains the group.
    # @return [JavaScriptCore::GlobalContext] A JavaScriptCore::GlobalContext with a global object of class globalObjectClass and a context
    def self.create_in_group(group,globalObjectClass)
      res = super(group,globalObjectClass)
      wrap = self.new(:pointer=>res)
      return wrap
    end

    # Retains a global JavaScript execution context.
    #
    # @return [JavaScriptCore::GlobalContext] A JavaScriptCore::GlobalContext that is the same as ctx.
    def retain()
      res = super(self)
    end

    # Releases a global JavaScript execution context.
    #
    def release()
      res = super(self)
      return res
    end
  end
end
