source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'
gem 'coffee-script'
gem 'devise'
gem 'geokit'
gem 'haml'
gem 'therubyracer', :platforms => :ruby
gem 'uglifier'

platforms :jruby do
  gem 'jruby-openssl'
  gem 'therubyrhino'
end

group :development, :production do
  gem 'pg'
end

group :production do
  gem 'unicorn'
end

group :test do
  gem 'ZenTest'
  gem 'simplecov'
  gem 'sqlite3'
  gem 'turn', :require => false
  gem 'webmock'
end
