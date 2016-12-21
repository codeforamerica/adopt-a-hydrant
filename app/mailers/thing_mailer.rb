class ThingMailer < ApplicationMailer
  def first_adoption_confirmation(thing)
    @thing = thing
    @user = thing.user

    mail(to: @user.email, subject: ["Thanks for adopting a drain, #{@user.name.split.first}! Here’s important info"])
  end

  def second_adoption_confirmation(thing)
    @thing = thing
    @user = thing.user
    mail(to: @user.email, subject: ["Thanks for adopting another drain, #{@user.name.split.first}!"])
  end

  def third_adoption_confirmation(thing)
    @thing = thing
    @user = thing.user
    mail(to: @user.email, subject: ["We really do love you, #{@user.name.split.first}!"])
  end

  def reminder(thing)
    @thing = thing
    @user = thing.user
    mail(to: @user.email, subject: ['Remember to clear your adopted drain'])
  end

  def drain_update_report(deleted_drains_with_adoptee, deleted_drains_no_adoptee, created_drains)
    @deleted_drain_ids_with_adoptee = deleted_drains_with_adoptee.map(&:city_id)
    @deleted_drain_ids_with_no_adoptee = deleted_drains_no_adoptee.map(&:city_id)
    @created_drain_ids = created_drains.map(&:city_id)
    subject = "Adopt-a-Drain import (#{deleted_drains_with_adoptee.count} adopted drains removed, #{created_drains.count} drains added, #{deleted_drains_no_adoptee.count} removed)"
    mail(to: User.where(admin: true).pluck(:email), subject: subject)
  end
end
