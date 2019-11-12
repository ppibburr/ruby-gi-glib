
#       ContextGroup.rb
             

# 
module JavaScriptCore
  module Lib
    class ContextGroup < JavaScriptCore::BaseObject

      # Creates a JavaScript context group.
      #
      # @return The created JSContextGroup.
      def self.create()
        JavaScriptCore::Lib.JSContextGroupCreate()
      end

      # Retains a JavaScript context group.
      #
      # @param [:JSContextGroupRef] group The JSContextGroup to retain.
      # @return A JSContextGroup that is the same as group.
      def retain(group)
        JavaScriptCore::Lib.JSContextGroupRetain(group)
      end
    end
  end
end
