# Backport of Rails 3.1.x Sprockets integration to Rails 3.0.x

## Usage

In your `Gemfile`:

    gem "sprockets_rails3_backport"

In your `routes.rb`:

    MyApp::Application.routes.draw do
      if (app = Rails.application).config.assets.compile
        mount app.assets => app.config.assets.prefix
      end
      
      # ...
    end

Here are the various `config.assets` options and their defaults:

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

`config.assets.enabled` is not used.