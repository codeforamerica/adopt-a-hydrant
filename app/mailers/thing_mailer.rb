class ThingMailer < ActionMailer::Base
  default :from => "hello@#{default_url_options[:host]}"

  def reminder_email(thing)
    @thing = thing
    @user = thing.user
    mail({
      :to => thing.user.email,
      :from => "reminder@#{default_url_options[:host]}",
      :subject => ["Remember to Shovel", thing.name].compact.join(' '),
    })
  end
end
