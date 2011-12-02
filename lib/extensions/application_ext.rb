module Rails
  class Application < Engine
    class Configuration < ::Rails::Engine::Configuration
      # we need to do this over again for Rails::Application::Configuration because
      # the Rails 3.0 implementation squashes the paths.vendor that we made in
      # application_ext.rb.
      
      def paths_with_vendor_assets
        @paths ||= begin
          paths = paths_without_vendor_assets
          paths.vendor              "vendor",              :load_path => true
          paths.vendor.assets       "vendor/assets",       :glob => "*"
          paths.vendor.plugins      "vendor/plugins"
          paths
        end
      end
      
      alias_method_chain :paths, :vendor_assets
      
      def initialize_with_assets(*args)
        initialize_without_assets(*args)
        @assets = ActiveSupport::OrderedOptions.new
        # @assets.enabled                  = false
        @assets.paths                    = []
        @assets.precompile               = [ Proc.new{ |path| !File.extname(path).in?(['.js', '.css']) },
                                             /(?:\/|\\|\A)application\.(css|js)$/ ]
        @assets.prefix                   = "/assets"
        @assets.version                  = ''
        @assets.debug                    = false
        @assets.compile                  = true
        @assets.digest                   = false
        @assets.manifest                 = nil
        @assets.cache_store              = [ :file_store, "#{root}/tmp/cache/assets/" ]
        @assets.js_compressor            = nil
        @assets.css_compressor           = nil
        @assets.initialize_on_precompile = true
      end
      
      alias_method_chain :initialize, :assets
      
      attr_accessor :assets
    end
    
    attr_accessor :assets
  end
end
