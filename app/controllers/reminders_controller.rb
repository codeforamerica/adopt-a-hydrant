# frozen_string_literal: true

class RemindersController < ApplicationController
  respond_to :json

  before_action :require_admin

  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.from_user = current_user
    if @reminder.save
      ThingMailer.reminder(@reminder.thing).deliver_later
      @reminder.update(sent: true)
      render(json: @reminder)
    else
      render(json: {errors: @reminder.errors}, status: :internal_server_error)
    end
  end

private

  def reminder_params
    params.require(:reminder).permit(:thing_id, :to_user_id)
  end
end
