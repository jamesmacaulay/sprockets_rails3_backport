lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "sprockets_rails3_backport"
  s.version     = '0.0.4'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James MacAulay"]
  s.email       = ["james@shopify.com"]
  s.homepage    = "http://github.com/jamesmacaulay/sprockets_rails3_backport"
  s.summary     = "Rails 3.1.x Sprockets functionality for Rails 3.0.x"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency('rails', '~> 3.0.0')
  s.add_dependency('sprockets', '2.1.2')

  s.files        = Dir.glob("lib/**/*") + %w(MIT-LICENSE README.markdown)
  s.require_path = 'lib'
end
