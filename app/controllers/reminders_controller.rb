class RemindersController < ApplicationController
  respond_to :json

  def create
    @reminder = Reminder.new(params[:reminder])
    if @reminder.save
      HydrantMailer.reminder_email(@reminder.hydrant).deliver
      @reminder.update_attribute(:sent, true)
      render(:json => @reminder)
    else
      render(:json => {"errors" => @reminder.errors}, :status => 500)
    end
  end
end
