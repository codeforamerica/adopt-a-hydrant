class RemindersController < ApplicationController
  respond_to :json

  def create
    @reminder = Reminder.new(params[:reminder])
    if @reminder.save
      ThingMailer.reminder(@reminder.thing).deliver
      @reminder.update_attribute(:sent, true)
      render(:json => @reminder)
    else
      render(:json => {"errors" => @reminder.errors}, :status => 500)
    end
  end
end
