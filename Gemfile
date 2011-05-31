source 'http://rubygems.org'

gem 'rails', '3.1.0.rc1'
gem 'coffee-script'
gem 'devise'
gem 'geokit'
gem 'haml'
gem 'sass'
gem 'uglifier'

platforms :jruby do
  gem 'jruby-openssl', '~> 0.7'
end

group :production do
  platforms :ruby do
    gem 'therubyracer-heroku', '0.8.1.pre3'
  end

  platforms :jruby do
    gem 'therubyrhino', '~> 1.72'
  end
end

group :development, :production do
  gem 'pg'
end

group :test do
  gem 'ZenTest'
  gem 'simplecov'
  gem 'sqlite3'
  gem 'turn', :require => false
  gem 'webmock'
end
