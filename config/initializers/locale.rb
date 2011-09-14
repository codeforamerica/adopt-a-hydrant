require 'rack'
require 'rack/contrib'

Rails.application.config.middleware.use Rack::Locale
