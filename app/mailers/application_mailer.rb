# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Adopt a Drain SF <info@sfwater.org>'
  layout 'mailer'
end
