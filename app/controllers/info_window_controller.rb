class InfoWindowController < ApplicationController
  def index
    @thing = Thing.find_by_id(params[:thing_id])
    if @thing.adopted?
      if user_signed_in? && current_user.id == @thing.user_id
        render("users/thank_you")
      else
        render("users/profile")
      end
    else
      if user_signed_in?
        render("things/adopt")
      else
        render("sessions/new")
      end
    end
  end
end
