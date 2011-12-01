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

    config.assets.paths                    = []
    config.assets.precompile               = [ Proc.new{ |path| !['.js', '.css'].include?(File.extname(path)) },
                                               /(?:\/|\\|\A)application\.(css|js)$/ ]
    config.assets.prefix                   = "/assets"
    config.assets.version                  = ''
    config.assets.debug                    = false
    config.assets.compile                  = true
    config.assets.digest                   = false
    config.assets.manifest                 = nil
    config.assets.cache_store              = false
    config.assets.js_compressor            = nil
    config.assets.css_compressor           = nil
    config.assets.initialize_on_precompile = true


## Differences from Rails 3.1.3

* no `config.assets.enabled`
* `config.assets.cache_store` defaults to false, so you probably want to set it yourself


