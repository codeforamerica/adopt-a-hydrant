class RemindersController < ApplicationController
  respond_to :json

  def create
    puts params[:reminder].inspect
    @reminder = Reminder.new(params[:reminder])

    if @reminder.save
      render(:json => @reminder)
    else
      render(:json => {"errors" => @reminder.errors}, :status => 500)
    end
    # ReminderMailer.send_reminder
    # @reminder.sent = true
    # @reminder.save!
  end
end
