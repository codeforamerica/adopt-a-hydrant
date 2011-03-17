class HydrantsController < ApplicationController
  respond_to :json

  def update
    @hydrant = Hydrant.find(params[:id])
    if @hydrant.update_attributes(params[:hydrant])
      render(:json => @hydrant)
    else
      render(:json => {"errors" => @hydrant.errors})
    end
  end
end
