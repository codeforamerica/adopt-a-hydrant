source 'https://rubygems.org'
ruby '2.2.3'

gem 'dotenv-rails', groups: [:development, :test]
gem 'rails', '~> 4.2.4'
gem 'airbrake', '~> 5.2'
gem 'devise', '~> 3.0'
gem 'geokit', '~> 1.0'
gem 'haml', '~> 4.0'
gem 'http_accept_language', '~> 2.0'
gem 'local_time', '~> 1.0'
gem 'obscenity', '~> 1.0', '>= 1.0.2'
gem 'pg'
gem 'rails_admin', '~> 1.0'
gem 'validates_formatting_of', '~> 0.9.0'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]
gem 'paranoia', '~> 2.2'

group :assets do
  gem 'sass-rails', '>= 4.0.3'
  gem 'uglifier'
end

group :development do
  gem 'byebug'
  gem 'spring'
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
  gem 'skylight'
end

group :test do
  gem 'coveralls', require: false
  gem 'simplecov', require: false
  gem 'rubocop'
  gem 'webmock'
end
