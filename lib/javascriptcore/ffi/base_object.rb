
#       base_object.rb
             

# 

module JavaScriptCore
  class BaseObject < FFI::AutoPointer
    OBJECTS = {}
      attr_accessor :pointer
	  def self.release ptr
		# puts "#{ptr} released"
		if is_a?(JavaScriptCore::Object)
		  OBJECTS.delete(ptr.address)
		  nil
		elsif is_a?(JavaScriptCore::PropertyNameArray)
		  puts "name array"
		end
	  end
	  
	  def self.is_wrapped?(ptr)
		  OBJECTS[ptr.address]
	  end
	  
	  def initialize(ptr)
		@pointer = ptr
		super
		if self.is_a?(JavaScriptCore::Object)
		  OBJECTS[ptr.address] = self
		end
	  end
	  
	  def to_ptr
		@pointer
	  end
	end
end

def check_use ptr
  nil
end
    
    
