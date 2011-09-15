class HydrantsController < ApplicationController
  respond_to :json

  def show
    @hydrants = Hydrant.find_closest(params[:lat], params[:lng], params[:limit] || 20)
    unless @hydrants.blank?
      respond_with @hydrants
    else
      render(:json => {"errors" => {"address" => [t("errors.hydrants")]}}, :status => 404)
    end
  end

  def update
    @hydrant = Hydrant.find(params[:id])
    if @hydrant.update_attributes(params[:hydrant])
      respond_with @hydrant
    else
      render(:json => {"errors" => @hydrant.errors}, :status => 500)
    end
  end
end
