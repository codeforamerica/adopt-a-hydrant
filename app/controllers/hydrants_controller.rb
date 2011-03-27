class HydrantsController < ApplicationController
  def show
    @hydrant = Hydrant.find_by_id(params[:hydrant_id])
    if @hydrant.adopted?
      if user_signed_in? && current_user.id == @hydrant.user_id
        render(:partial => "users/thank_you")
      else
        render(:partial => "users/profile")
      end
    else
      if user_signed_in?
        render(:partial => "adopt")
      else
        render(:partial => "users/new")
      end
    end
  end

  def list
    @hydrants = Hydrant.find_closest(params[:lat], params[:lng])
    unless @hydrants.blank?
      render(:json => @hydrants)
    else
      render(:json => {"errors" => {"address" => ["Could not find address."]}})
    end
  end

  def update
    @hydrant = Hydrant.find(params[:id])
    if @hydrant.update_attributes(params[:hydrant])
      render(:json => @hydrant)
    else
      render(:json => {"errors" => @hydrant.errors})
    end
  end
end
