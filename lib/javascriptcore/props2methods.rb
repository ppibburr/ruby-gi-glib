
#       props2methods.rb
             

# 

#       props2methods.rb
             

# 

#       props2methods.rb
             

# 
module RubyJS
  def self.decamelize s
    while s =~ /([a-z])([A-Z])/
      s = s.gsub("#{$1}#{$2}","#{$1}_#{$2}")
    end
    s.downcase
  end
  
  def self.camelize s
    while s =~ /([a-z])\_([a-z])/
      s = s.gsub("#{$1}_#{$2}","#{$1}#{$2.upcase}")
    end
    s
  end
end

class JavaScriptCore::Object
  def method_missing sym,*o,&b
    sym = sym.to_s
    
    if sym =~ /(.*)=$/
      sym = $1
      is_setter = true
    end
    r = nil
    if is_setter
      self[sym] = o[0]
    elsif has_property(sym)
      r = self[sym]
    elsif has_property(q=RubyJS.camelize(sym))
      r = self[q]
    else
      return super sym,*o,&b
    end
    if r.is_a?(JavaScriptCore::Object) and r.is_function
      return r.call(*o,&b)
    end
    if r.is_a?(Symbol) and r == :undefined
      return super
    end
    r
  rescue => e
    p sym
    p e.backtrace.join("\n")
    super sym.to_sym,*o,&b
  end
end
