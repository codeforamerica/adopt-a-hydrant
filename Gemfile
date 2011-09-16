source 'http://rubygems.org'

gem 'rails', '~> 3.1.0'

gem 'arel'
gem 'devise'
gem 'geokit'
gem 'haml', '~> 3.2.0.alpha'
gem 'pg'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'rack-contrib'

platforms :jruby do
  gem 'jruby-openssl'
  gem 'therubyrhino'
end

platforms :ruby_18 do
  gem 'fastercsv'
end

group :assets do
  gem 'uglifier'
end

group :production do
  gem 'thin'
end

group :test do
  gem 'simplecov'
  gem 'sqlite3'
  gem 'webmock'
end
