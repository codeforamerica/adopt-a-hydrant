# http://oldwiki.rubyonrails.org/rails/pages/HowtoWorkWithSessions
class InfoWindowController < ApplicationController
  def index
    # @thing = Thing.find_by_id(params[:thing_id])
    session[:thing] = Thing.find_by_id(params[:thing_id])
    session[:thing] = Thing.find_by_id(session[:id]) if session[:thing].nil?
    
    if session[:thing].adopted?
      if user_signed_in? && current_user.id == session[:thing].user_id
        if session[:conflict] == true
          render('users/conflict')
        else
          render("users/thank_you")
        end
      else
        render("users/profile")
      end
    else
      if user_signed_in?
        render("things/adopt")
      else
        render("users/sign_in")
      end
    end
  end
end
