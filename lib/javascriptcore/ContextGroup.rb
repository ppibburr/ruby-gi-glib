
#       ContextGroup.rb
             

# 
module JavaScriptCore
  class ContextGroup < JavaScriptCore::Lib::ContextGroup

    class << self
      alias :real_new :new
    end  
      
    def self.new *o
      if o[0].is_a? Hash and o[0][:pointer] and o.length == 1
        real_new o[0][:pointer]
      else
        return JavaScriptCore::ContextGroup.create(*o)
      end
    end
      

    # Creates a JavaScript context group.
    #
    # @return [JavaScriptCore::ContextGroup] The created JavaScriptCore::ContextGroup.
    def self.create()
      res = super()
      wrap = self.new(:pointer=>res)
      return wrap
    end

    # Retains a JavaScript context group.
    #
    # @return [JavaScriptCore::ContextGroup] A JavaScriptCore::ContextGroup that is the same as group.
    def retain()
      res = super(self)
    end
  end
end
