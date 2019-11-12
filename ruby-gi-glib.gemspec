require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'webkit2-web-extension', 'version'))

Gem::Specification.new do |gem|
  gem.name    = 'ruby-gi-glib'
  gem.version = "0.1.0"
 # gem.date    = Date.today.to_s

  gem.summary = "Load time and feature completeness over ruby-gnome gi bindings"
  gem.description = gem.summary

  gem.authors  = ['ppibburr']
  gem.email    = 'tulnor33@gmail.com'
  gem.homepage = 'http://github.com/ppibburr/ruby-gi-glib'

  gem.add_dependency('rake')
  gem.add_dependency('gtk3')
  
  # ensure the gem is built out of versioned files
  gem.files = (Dir['Rakefile', '{bin,lib,man,test,spec, ext}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")).push(*Dir.glob("./ext/*/*.so"))
  
  gem.require_paths = ["lib"]
end
