module WebKit2Gtk
  class Loader < GObjectIntrospection::Loader
    NAMESPACE = "WebKit2"

    def load
      super(NAMESPACE)
    end

    private
    def pre_load(repository, namespace)
      define_version_module
    end

    def post_load(repository, namespace)
      require_libraries
    end

    def define_version_module
      @version_module = Module.new
      @base_module.const_set("Version", @version_module)
    end

    def require_libraries
      #require "webkit2-gtk/version" if @version_module.const_defined?(:MAJOR)

      #require "webkit2-gtk/web-context"
      #require "webkit2-gtk/web-view"
    end

    def load_constant_info(info)
      case info.name
      when /_VERSION\z/
        @version_module.const_set($PREMATCH, info.value)
      else
        super
      end
    end
  end
end

module WebKit2Gtk
  class << self
    def const_missing(name)
      init
      if const_defined?(name)
        const_get(name)
      else
        super
      end
    end

    def init
      class << self
        remove_method(:init)
        remove_method(:const_missing)
      end
      Gtk.init if Gtk.respond_to?(:init)
      loader = Loader.new(self)
      loader.load
    end
  end
end
