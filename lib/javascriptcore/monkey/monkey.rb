module JavaScriptCore
  def self.patch_webkit
    require File.join(File.dirname(__FILE__),'patch_webkitgtk')
  end

  def self.patch_webkit2
    require File.join(File.dirname(__FILE__),'patch_webkit2gtk')
  end
  
  def self.patch_webkit2_web_extension
    require File.join(File.dirname(__FILE__),'patch_webkit2-web-extension')
  end  
end
