class AddressesController < ApplicationController
  respond_to :json

  def show
    @address = Address.geocode("#{params[:address]}, #{params[:city_state]}")
    unless @address.blank?
      respond_with @address
    else
      render(:json => {"errors" => {"address" => [t("errors.address")]}}, :status => 404)
    end
  end
end
