# Backport of Rails 3.1.x Sprockets integration to Rails 3.0.x

Most code has been extracted from the [Rails 3-1-stable branch](https://github.com/rails/rails/tree/3-1-stable). Modified to suit [our needs](http://www.shopify.com).


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

    config.assets.paths                    = []
    config.assets.precompile               = [ Proc.new{ |path| !['.js', '.css'].include?(File.extname(path)) },
                                               /(?:\/|\\|\A)application\.(css|js)$/ ]
    config.assets.prefix                   = "/assets"
    config.assets.version                  = ''
    config.assets.debug                    = false
    config.assets.compile                  = true
    config.assets.digest                   = false
    config.assets.manifest                 = nil
    config.assets.cache_store              = [ :file_store, "#{root}/tmp/cache/assets/" ]
    config.assets.js_compressor            = nil
    config.assets.css_compressor           = nil
    config.assets.initialize_on_precompile = true

`config.assets.enabled` is not used.