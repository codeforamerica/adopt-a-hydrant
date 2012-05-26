# http://www.engineyard.com/blog/2011/a-guide-to-optimistic-locking/
# http://railscasts.com/episodes/13-dangers-of-model-in-session
class ThingsController < ApplicationController
  respond_to :json

  def show
    @things = Thing.find_closest(params[:lat], params[:lng], params[:limit] || 10)
    unless @things.blank?
      respond_with @things
    else
      render(:json => {"errors" => {"address" => [t("errors.not_found", :thing => t("defaults.thing"))]}}, :status => 404)
    end
  end

  def update
    session[:conflict] = false
    session[:id] = session[:thing].id
    if session[:thing].update_attributes(params[:thing])
      respond_with session[:thing]
    else
      render(:json => {"errors" => session[:thing].errors}, :status => 500)
    end
    rescue ActiveRecord::StaleObjectError
      session[:conflict] = true
      redirect_to(:controller => "info_window", :action => "index")
  end
end