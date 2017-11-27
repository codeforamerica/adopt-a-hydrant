source 'https://rubygems.org'
ruby '2.2.3'

gem 'airbrake', '~> 7.1'
gem 'devise', '~> 3.0'
gem 'geokit', '~> 1.0'
gem 'haml', '~> 5.0'
gem 'http_accept_language', '~> 2.0'
gem 'local_time', '~> 2.0'
gem 'obscenity', '~> 1.0', '>= 1.0.2'
gem 'pg'
gem 'rails', '~> 4.2.10'
gem 'rails_admin', '~> 1.0'
gem 'validates_formatting_of', '~> 0.9.0'

gem 'paranoia', '~> 2.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw]

gem 'byebug', groups: %i[development test]
gem 'dotenv-rails', groups: %i[development test]

group :assets do
  gem 'sass-rails', '>= 4.0.3'
  gem 'uglifier'
end

group :development do
  gem 'spring'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'skylight'
end

group :test do
  gem 'coveralls', require: false
  gem 'rubocop'
  gem 'simplecov', require: false
  gem 'webmock'
end
