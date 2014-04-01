# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

if Rails.env.production? && ENV['SECRET_TOKEN'].blank?
  fail 'The SECRET_TOKEN environment variable is not set.\n
    To generate it, run "rake secret", then set it with "heroku config:set SECRET_TOKEN=the_token_you_generated"'
end

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
AdoptAThing::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || 'cfc501e00aeb29750826f86459cccec45ea2c7dd84e8fc0b800dced308be95059b51c3402d215d267cfc09f03bd6f1f531a65456212b3531ef2b10cf605dc39a'
