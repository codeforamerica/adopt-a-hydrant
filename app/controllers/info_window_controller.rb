class InfoWindowController < ApplicationController
  def index
    @hydrant = Hydrant.find_by_id(params[:hydrant_id])
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
