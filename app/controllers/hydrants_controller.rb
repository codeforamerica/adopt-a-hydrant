class HydrantsController < ApplicationController
  respond_to :json

  def update
    @hydrant = Hydrant.find(params[:id])
    if @hydrant.update_attributes(params[:hydrant])
      respond_with @hydrant
    else
      render(:json => {"errors" => @hydrant.errors})
    end
  end
end
