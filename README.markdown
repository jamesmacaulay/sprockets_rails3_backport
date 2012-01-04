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

## Differences from Rails 3.1

This gem was made for [Shopify](http://www.shopify.com)'s use, and I've made some changes to some behaviour that either didn't work in Rails 3.0, or didn't make sense for Shopify:

* `image_path` (and therefore `image_tag`) [do not use the asset pipeline](https://github.com/jamesmacaulay/sprockets_rails3_backport/blob/d4cd5e5/lib/sprockets/helpers/rails_helper.rb#L60-63).
* Rails 3.0 does not have support for initializer groups, so `rake assets:precompile` [cannot do the trick of partially loading the environment](https://github.com/jamesmacaulay/sprockets_rails3_backport/blob/d4cd5e5/lib/sprockets/assets.rake#L97-98).
* precompilation [does not output gzipped versions of assets](https://github.com/jamesmacaulay/sprockets_rails3_backport/blob/d4cd5e5/lib/sprockets/static_compiler.rb#L39).
* `javascript_path` and `stylesheet_path` helpers have been fixed to [append the appropriate file extension if there's none provided](https://github.com/jamesmacaulay/sprockets_rails3_backport/blob/d4cd5e5/lib/sprockets/helpers/rails_helper.rb#L65-73).
* computing digests in the view helpers [no longer throws an error](https://github.com/jamesmacaulay/sprockets_rails3_backport/blob/d4cd5e5/lib/sprockets/helpers/rails_helper.rb#L145-146) if the digest is not found and `config.assets.compile` is off.
* `config.assets.enabled` [is](https://github.com/jamesmacaulay/sprockets_rails3_backport/blob/d4cd5e5/lib/sprockets/railtie.rb#L18) [not](https://github.com/jamesmacaulay/sprockets_rails3_backport/blob/d4cd5e5/lib/extensions/application_ext.rb#L22) [used](https://github.com/jamesmacaulay/sprockets_rails3_backport/blob/d4cd5e5/lib/sprockets/assets.rake#L30-33).
