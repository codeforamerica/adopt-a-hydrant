class ThingMailer < ApplicationMailer
  def first_adoption_confirmation(thing)
    @thing = thing
    @user = thing.user

    mail(to: @user.email, subject: ["Thanks for adopting a drain, #{@user.name.split.first}! Here’s important info"])
  end

  def second_adoption_confirmation(thing)
    @thing = thing
    @user = thing.user
    mail(to: @user.email, subject: ["You're a drain-tastic person, #{@user.name.split.first}!"])
  end

  def third_adoption_confirmation(thing)
    @thing = thing
    @user = thing.user
    mail(to: @user.email, subject: ["We really do love you, #{@user.name.split.first}!"])
  end

  def reminder(thing)
    @thing = thing
    @user = thing.user
    mail(to: @user.email, subject: ['Remember to clear Drain', @thing.name].compact.join(' '))
  end
end
