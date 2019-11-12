
#       Context.rb
             

# 
module JavaScriptCore
  module Lib
    class Context < JavaScriptCore::BaseObject

      # Gets the global object of a JavaScript execution context.
      #
      # @param [:JSContextRef] ctx The JSContext whose global object you want to get.
      # @return ctx's global object.
      def get_global_object(ctx)
        JavaScriptCore::Lib.JSContextGetGlobalObject(ctx)
      end

      # Gets the context group to which a JavaScript execution context belongs.
      #
      # @param [:JSContextRef] ctx The JSContext whose group you want to get.
      # @return ctx's group.
      def get_group(ctx)
        JavaScriptCore::Lib.JSContextGetGroup(ctx)
      end
    end
  end
end
