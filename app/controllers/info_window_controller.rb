class InfoWindowController < ApplicationController
  def index
    @hydrant = Hydrant.find_by_id(params[:hydrant_id])
    if params[:flash]
      params[:flash].each do |key, message|
        flash.now[key.to_sym] = message
      end
    end
    if @hydrant.adopted?
      if user_signed_in? && current_user.id == @hydrant.user_id
        render("users/thank_you")
      else
        render("users/profile")
      end
    else
      if user_signed_in?
        render("hydrants/adopt")
      else
        render("sessions/new")
      end
    end
  end
end
