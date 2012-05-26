# http://about.travis-ci.org/docs/user/languages/ruby/
source 'https://rubygems.org'

gem "rails", '~> 3.2'

gem 'arel'
gem 'devise'
gem 'geokit'
gem 'haml', '~> 3.2.0.alpha'
gem 'http_accept_language'
gem 'pg'
gem 'rails_admin'
gem 'validates_formatting_of'
gem 'immigrant'
gem 'twilio-ruby'
gem 'libxml-ruby'

platforms :ruby_18 do
  gem 'fastercsv'
end

group :assets do
  gem 'sass-rails'
  gem 'uglifier'
end

group :production do
  gem 'puma'
end

group :test do
  gem 'simplecov'
  gem 'sqlite3'
  gem 'webmock'
  gem 'rake'
  # gem 'cucumber-rails', :require => false
  # gem 'database_cleaner'
  # gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  # gem 'guard-livereload'
  # gem 'guard-webrick'
  # gem 'guard-puma'
end