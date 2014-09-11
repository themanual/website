source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~> 4.0.2'

gem 'sass-rails', '~> 4.0.0'
gem 'bourbon'
gem 'neat'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem "bower-rails", "~> 0.8.3"

gem 'cssminify' # replaces 'yui-compressor'
gem 'sprockets-image_compressor'
gem 'autoprefixer-rails'

gem 'kramdown'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2'

gem "second_level_cache", "~> 2.0.0"
gem 'dalli'
gem 'kgio'

gem 'pg'

# email css inlining
gem 'premailer-rails'
gem 'nokogiri'

gem 'puma'

gem 'devise'

gem 'activeadmin', github: 'gregbell/active_admin'
gem 'codemirror-rails'
gem 'chosen-rails'

gem 'acts-as-taggable-on'

gem 'shoppe', github: 'tryshoppe/core', branch: 'master', require: 'shoppe'
# pull request accepted, but no new gem release yet
# gem 'shoppe', '~> 0.0.0'

gem 'shoppe-stripe', '~> 1.2.1', :require => 'shoppe/stripe'
gem 'stripe'

# to be built by Marc
# gem 'shoppe-shipwire'
gem 'shipwire', github: 'marcroberts/shipwire'

gem 'airbrake'

gem 'numbers_and_words'
gem 'ish'

gem 'rack-no-www'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'debugger'
  gem 'guard-pow', require: false
  gem 'guard-livereload'
  gem 'terminal-notifier-guard', require: false
  gem 'quiet_assets'
  gem 'dotenv-rails'
end

group :production, :stage, :beta do
	gem 'memcachier'
  gem 'rails_12factor'
  gem 'heroku-deflater'

  gem 'newrelic_rpm'
	gem 'lograge'
end


gem 'rack-mini-profiler'
