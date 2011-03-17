class HydrantsController < ApplicationController
  respond_to :json

  def index
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
      render(:json => @hydrant)
    else
      render(:json => {"errors" => @hydrant.errors})
    end
  end
end
