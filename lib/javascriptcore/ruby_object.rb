
#       ruby_object.rb
             

# 
class JavaScriptCore::RubyObject < JavaScriptCore::Object
  class << self
    alias :ro_new :new
  end
  
  def self.new(ctx,object=Object)
    res = ro_new(:pointer=>JavaScriptCore::Lib::JSObjectMake(ctx,CLASS,nil))
    res.context = ctx
    PTRS[res.pointer.address]=res
    res.object = object
    res
  end
end



class JavaScriptCore::RubyObject < JavaScriptCore::Object
  PTRS = {}
  PROCS = {}
  CLASS_DEF = JavaScriptCore::Lib::JSClassDefinition.new
  
  CLASS_DEF[:getProperty] = pr = proc do |ctx,obj,name,err|
    if (n=JavaScriptCore.read_string(name,false)) == "object_get_property"
      nil
    else
      o=PTRS[obj.address]
      o.object_get_property(n)
    end
  end
  PROCS[pr] = true
  
  # IMPORTANT: set definition fields before creating class
  CLASS = JavaScriptCore::Lib.JSClassCreate(CLASS_DEF)

  attr_accessor :object
  
  def object_has_property? n
    if object.respond_to?(n)
      true
    elsif object.private_methods.index(n.to_sym)
      true
    elsif object.respond_to?(:constants)
      !!object.constants.index(n.to_sym)
    else
      nil
    end   
  end
  def js_send this,*o,&b
    send *o,&b
  end
  def object_get_property n
    return nil if !object_has_property?(n)
    m = nil
    
    if object.respond_to?(n) or object.private_methods.index(n.to_sym)
      m =object.method(n)
    elsif object.respond_to?(:constants)
      m = object.const_get n.to_sym
    end
    
    o = nil
    
    if m.respond_to?(:call)
      o = JavaScriptCore::Object.new(context) do |*a|
        this = a.shift
        closure = nil
        if a.last.is_a?(JavaScriptCore::Object) and a.last.is_function
          closure = a.pop
          closure.context = context
        end
        q=m.call(*a) do |*args|
          closure.call(*args) if closure
        end
        JavaScriptCore::Value.from_ruby(context,q)
      end
    else
      o = m
    end

    v = JavaScriptCore::Value.from_ruby(context,o)#.to_ptr
    v.to_ptr
  end
end
