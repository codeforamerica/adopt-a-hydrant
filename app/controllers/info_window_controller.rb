class InfoWindowController < ApplicationController
  def index
    @thing = Thing.find_by_id(params[:thing_id])
    view = begin
      if @thing.adopted?
        user_signed_in? && current_user == @thing.user ? 'users/thank_you' : 'users/profile'
      else
        user_signed_in? ? 'things/adopt' : 'users/sign_in'
      end
    end
    render view
  end
end
