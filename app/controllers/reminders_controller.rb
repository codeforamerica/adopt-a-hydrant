class RemindersController < ApplicationController
  respond_to :json

  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.from_user = current_user
    if @reminder.save
      ThingMailer.reminder(@reminder.thing).deliver
      @reminder.update_attribute(:sent, true)
      render(json: @reminder)
    else
      render(json: {errors: @reminder.errors}, status: 500)
    end
  end

private

  def reminder_params
    params.require(:reminder).permit(:thing_id, :to_user_id)
  end
end
