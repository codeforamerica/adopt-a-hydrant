# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

if Rails.env.production? && ENV['SECRET_TOKEN'].blank?
	raise 'The SECRET_TOKEN environment variable is not set.\n
	To generate it, run "rake secret", then set it with "heroku config:set SECRET_TOKEN=the_token_you_generated"'
end

AdoptAThing::Application.config.secret_token = ENV['SECRET_TOKEN'] || '4dc0354d5050c89c7f151a0bae3d2a7506a7ca66435ae9e0eb6754cb4be808089c7726c65dc8ae9b49870507fbe0de1fa36fa703491078b2c7122897892d6f69'
