source 'https://rubygems.org'
ruby '2.1.1'

gem 'rails', '~> 4.0.3'

gem 'arel'
gem 'devise'
gem 'geokit'
gem 'haml'
gem 'http_accept_language'
gem 'nokogiri'
gem 'pg'
gem 'rails_12factor'
gem 'rails_admin'
gem 'validates_formatting_of'

platforms :ruby_18 do
  gem 'fastercsv'
end

group :assets do
  gem 'sass-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'pry'
end

group :production do
  gem 'puma'
end

group :test do
  gem 'coveralls', :require => false
  gem 'simplecov', :require => false
  gem 'sqlite3'
  gem 'webmock'
end
