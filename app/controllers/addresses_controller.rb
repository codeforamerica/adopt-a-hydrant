class AddressesController < ApplicationController
  def show
    @address = Address.find_lat_lng("#{params[:address]}, #{params[:city_state]}")
    unless @address.blank?
      render(:json => @address)
    else
      render(:json => {"errors" => {"address" => ["Could not find address."]}})
    end
  end
end
