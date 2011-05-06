class AddressesController < ApplicationController
  respond_to :json

  def show
    @address = Address.find_lat_lng("#{params[:address]}, #{params[:city_state]}")
    unless @address.blank?
      respond_with @address
    else
      render(:json => {"errors" => {"address" => ["Could not find address."]}})
    end
  end
end
