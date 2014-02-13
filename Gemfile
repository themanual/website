source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~> 4.0.2'

gem 'sass-rails', '~> 4.0.0'
gem 'bourbon'
gem 'neat'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem "bower-rails", "~> 0.6.1"

gem 'cssminify' # replaces 'yui-compressor'
gem 'sprockets-image_compressor'

gem 'kramdown'


# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

gem "second_level_cache", "~> 2.0.0"
gem 'dalli'
gem 'kgio'

gem 'puma'

gem 'devise'

gem 'activeadmin', github: 'gregbell/active_admin'
gem 'codemirror-rails'
gem 'chosen-rails'

gem 'shoppe', github: 'marcroberts/core', branch: 'patch-1', require: 'shoppe'
# awaiting acceptance of my pull request - MR
# gem 'shoppe', '~> 0.0.0'

gem 'shoppe-stripe', '~> 1.2.1', :require => 'shoppe/stripe'

# to be built by Marc
# gem 'shoppe-shipwire'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'debugger'
  gem 'sqlite3'
  gem 'guard-livereload'
  gem 'quiet_assets'
  gem 'dotenv-rails'
end

group :production, :stage do
	gem 'memcachier'
  gem 'rails_12factor'
  gem 'rack-cache'

  gem 'newrelic_rpm'
	gem 'airbrake'
	gem 'lograge'

  gem 'pg'
end