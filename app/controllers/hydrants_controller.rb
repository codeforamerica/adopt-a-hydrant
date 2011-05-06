class HydrantsController < ApplicationController
  respond_to :json, :only => [:list, :update]

  def show
    @hydrant = Hydrant.find_by_id(params[:hydrant_id])
    if @hydrant.adopted?
      if user_signed_in? && current_user.id == @hydrant.user_id
        render("users/thank_you", :layout => "info_window")
      else
        render("users/profile", :layout => "info_window")
      end
    else
      if user_signed_in?
        render("adopt", :layout => "info_window")
      else
        render("sessions/new", :layout => "info_window")
      end
    end
  end

  def list
    @hydrants = Hydrant.find_closest(params[:lat], params[:lng])
    unless @hydrants.blank?
      respond_with @hydrants
    else
      render(:json => {"errors" => {"address" => ["Could not find address."]}})
    end
  end

  def update
    @hydrant = Hydrant.find(params[:id])
    if @hydrant.update_attributes(params[:hydrant])
      respond_with @hydrant
    else
      render(:json => {"errors" => @hydrant.errors})
    end
  end
end
