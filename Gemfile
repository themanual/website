source 'https://rubygems.org'

gem 'rails', '~> 4.0.2'

gem 'sass-rails', '~> 4.0.0'
gem 'bourbon'
gem 'neat'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

gem 'cssminify' # replaces 'yui-compressor'

gem 'kramdown'


# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

gem 'pg'

gem 'dalli'
gem 'kgio'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'debugger'

  gem 'webrick'
end

group :production, :stage do
	gem 'memcachier'
  gem 'rails_12factor'
  gem 'rack-cache'

  gem 'newrelic_rpm'
	gem 'airbrake'
	gem 'lograge'

  gem 'puma'
end