source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'
gem 'coffee-script'
gem 'devise'
gem 'geokit'
gem 'haml'
gem 'uglifier'

gem 'jruby-openssl', :platforms => :jruby

group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3', :platforms => :ruby
end

group :development, :production do
  gem 'pg'
end

group :test do
  gem 'ZenTest'
  gem 'simplecov'
  gem 'sqlite3'
  gem 'therubyracer', :platforms => :ruby
  gem 'therubyrhino', :platforms => :jruby
  gem 'turn', :require => false
  gem 'webmock'
end
