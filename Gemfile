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

gem 'kramdown'


# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

gem 'dalli'
gem 'kgio'

gem 'puma'

gem 'devise'

# gem 'activeadmin', github: 'gregbell/active_admin'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'debugger'
  gem 'sqlite3'
  gem 'guard-livereload'
  gem 'quiet_assets'
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