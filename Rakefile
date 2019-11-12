desc "build webkit2-web-extension ruby loader extension"
task :ext do  
  sh 'cd ext/webkit2-web-extension && gcc -g ./rb-webkit2-web-extension.c $(pkg-config --cflags --libs ruby) $(pkg-config --cflags --libs webkit2gtk-web-extension-4.0) -o extension.so -fPIC -shared'
end

desc 'Build gem'
task :gem => [:ext] do
  sh 'gem build ruby-gi-glib.gemspec' 
end

desc 'Installs gem'
task :install => [:gem] do
  sh "gem i -l ruby-gi-glib*.gem"
end
