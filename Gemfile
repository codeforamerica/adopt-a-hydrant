source 'http://rubygems.org'

gem 'rails', '3.1.0.beta1'
gem 'coffee-script'
gem 'devise'
gem 'geokit'
gem 'haml'
gem 'pg'
gem 'sass'

platforms :jruby do
  gem 'jruby-openssl', '~> 0.7'
end

group :test do
  gem 'simplecov'
  gem 'sqlite3'
  gem 'turn', :require => false
  gem 'webmock'
end

group :test, :production do
  gem 'therubyracer-heroku', '0.8.1.pre3'
end
