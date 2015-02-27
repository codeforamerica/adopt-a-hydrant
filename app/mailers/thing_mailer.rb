class ThingMailer < ActionMailer::Base
  default from: 'team@brewingabetterforest.com'

  def reminder(thing)
    @thing = thing
    @user = thing.user
    mail(to: thing.user.email, subject: ['Remember to water', thing.name].compact.join(' '))
  end
end
