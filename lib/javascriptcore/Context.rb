
#       Context.rb
             

# 
module JavaScriptCore
  module Context

    # Gets the global object of a JavaScript execution context.
    #
    # @return [JavaScriptCore::Object] ctx's global object.
    def get_global_object()
      res = JavaScriptCore::Lib.JSContextGetGlobalObject(self)
      context = self
      return JavaScriptCore::BaseObject.is_wrapped?(res) || JavaScriptCore::Object.from_pointer_with_context(context,res)
    end

    # Gets the context group to which a JavaScript execution context belongs.
    #
    # @return [JavaScriptCore::ContextGroup] ctx's group.
    def get_group()
      res = JavaScriptCore::Lib.JSContextGetGroup(self)
    end
  end
end
