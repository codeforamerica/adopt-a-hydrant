class ThingMailer < ActionMailer::Base
  default from: 'adoptadrain@codeforsanfrancisco.org'

  def adopted_confirmation(thing)
    @thing = thing
    @user = thing.user
    mail(to: @user.email, subject: ['Thank you for Adopting a Drain in San Francico'])
  end

  def reminder(thing)
    @thing = thing
    @user = thing.user
    mail(to: @user.email, subject: ['Remember to shovel', @thing.name].compact.join(' '))
  end
end
