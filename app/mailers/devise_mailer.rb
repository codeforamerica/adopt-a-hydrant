class DeviseMailer < Devise::Mailer
  def reset_password_instructions(record, token, opts = {})
    mail = super
    mail.subject = t('devise.mailer.reset_password_instructions.subject', title: t('titles.main', thing: t('defaults.thing')))
    mail
  end
end
