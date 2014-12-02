source 'https://rubygems.org'

ruby '2.1.3'

gem 'rails', '~> 4.1.0'

# Assets
gem 'sass-rails', '~> 4.0.0'
gem 'bourbon'
gem 'neat'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'bower-rails', '~> 0.8.3'
gem 'cssminify' # replaces 'yui-compressor'
gem 'sprockets-image_compressor'
gem 'autoprefixer-rails'
gem 'codemirror-rails'
gem 'chosen-rails'
gem 'handlebars_assets'

# Markdown Parsing
gem 'kramdown'

# Emailing
gem 'premailer-rails'

# Tagging
gem 'acts-as-taggable-on'

# Authentication and Admin
gem 'devise', '~> 3.4.0'
gem 'activeadmin', github: 'activeadmin'
gem 'bcrypt', '~> 3.1.2'

# Store and Payments
gem 'shoppe', '~> 1.0.2'
gem 'shoppe-stripe', :github => 'tryshoppe/stripe', :require => 'shoppe/stripe'
gem 'stripe'
gem 'shipwire', github: 'marcroberts/shipwire' # gem 'shoppe-shipwire' to be built by Marc

# Utilities
gem 'nokogiri'
gem 'numbers_and_words'
gem 'ish'
gem 'smarter_csv'

# Database
gem 'pg'

# Digital asset storage
gem 'paperclip', '~> 4.2.0'
gem 'fog', '~> 1.21'

# Caching
gem 'second_level_cache', '~> 2.1.2'
gem 'dalli'
gem 'kgio'

# Server Stuff
gem 'puma'
# gem 'puma_worker_killer'
gem 'rack-timeout'
gem 'airbrake'
gem 'rack-no-www'
gem 'rack-mini-profiler'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  # gem 'debugger'
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
