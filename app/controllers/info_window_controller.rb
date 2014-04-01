class InfoWindowController < ApplicationController
  def index
    @thing = Thing.find_by_id(params[:thing_id])
    if @thing.adopted?
      if user_signed_in? && current_user == @thing.user
        render('users/thank_you')
      else
        render('users/profile')
      end
    else
      if user_signed_in?
        render('things/adopt')
      else
        render('users/sign_in')
      end
    end
  end
end
