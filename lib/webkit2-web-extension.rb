$: << File.expand_path(File.dirname(__FILE__))

require "webkit2-web-extension/version"
require "webkit2-web-extension/extension"
require "webkit2-web-extension/javascriptcore"

begin  
  WebKit2WebExtension.default.run()
rescue => e
  p e
end
