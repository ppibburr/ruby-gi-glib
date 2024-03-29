require 'webkit2-web-extension/config'

w = Gtk::Window.new :toplevel

WebKit2WebExtension.ipc_service do |srv|
  srv.accept do |c|
    p ipc_accept: c
    c.puts '{"value": "ACCEPT"}'
  end
  
  srv.message do |m, c|
    p(ipc_srv_rcv_msg: {client: c, message: m=JSON.parse(m)})
    c.puts '{"no": "way"}'
    w.show_all if m['action']
  end 
end

WebKit2WebExtension.config extension: File.expand_path(File.join(File.dirname(__FILE__), 'extension', 'extension.rb')),
                           data:      {foo: 5}
                           

w.add wv = WebKit2Gtk::WebView.new()
wv.load_html "","foo"
wv.run_javascript('console.log("Hello!");') do |wv,r|
  wv.run_javascript_finish(r)
end
w.resize 680,400



w.signal_connect "delete-event" do
  Gtk.main_quit
end

Gtk.main
