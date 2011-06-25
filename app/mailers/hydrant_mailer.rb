class HydrantMailer < ActionMailer::Base
  default :from => "hello@#{default_url_options[:host]}"

  def reminder_email(hydrant)
    @hydrant = hydrant
    @user = hydrant.user
    mail({
      :to => hydrant.user.email,
      :from => "reminder@#{default_url_options[:host]}",
      :subject => ["Remember to Shovel", hydrant.name].compact.join(' '),
    })
  end
end
