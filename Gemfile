source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'
gem 'arel', '2.1.4'
gem 'devise'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'geokit'
gem 'haml', '~> 3.2.0.alpha'
gem 'therubyracer', :platforms => :ruby

platforms :jruby do
  gem 'jruby-openssl'
  gem 'therubyrhino'
end

group :assets do
  gem 'uglifier'
end

group :development, :production do
  gem 'pg'
end

group :test do
  gem 'ZenTest'
  gem 'simplecov'
  gem 'sqlite3'
  gem 'webmock'
end
