
#       GlobalContext.rb
             

# 
module JavaScriptCore
  module Lib
    class GlobalContext < JavaScriptCore::BaseObject

      # Creates a global JavaScript execution context.
      #
      # @param [:JSClassRef] globalObjectClass The class to use when creating the global object. Pass
      # @return A JSGlobalContext with a global object of class globalObjectClass.
      def self.create(globalObjectClass)
        JavaScriptCore::Lib.JSGlobalContextCreate(globalObjectClass)
      end

      # Creates a global JavaScript execution context in the context group provided.
      #
      # @param [:JSClassRef] globalObjectClass The class to use when creating the global object. Pass
      # @param [:JSContextGroupRef] group The context group to use. The created global context retains the group.
      # @return A JSGlobalContext with a global object of class globalObjectClass and a context
      def self.create_in_group(group,globalObjectClass)
        JavaScriptCore::Lib.JSGlobalContextCreateInGroup(group,globalObjectClass)
      end

      # Retains a global JavaScript execution context.
      #
      # @param [:JSGlobalContextRef] ctx The JSGlobalContext to retain.
      # @return A JSGlobalContext that is the same as ctx.
      def retain(ctx)
        JavaScriptCore::Lib.JSGlobalContextRetain(ctx)
      end

      # Releases a global JavaScript execution context.
      #
      # @param [:JSGlobalContextRef] ctx The JSGlobalContext to release.
      def release(ctx)
        JavaScriptCore::Lib.JSGlobalContextRelease(ctx)
      end
    end
  end
end
