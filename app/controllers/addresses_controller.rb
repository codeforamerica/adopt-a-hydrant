class AddressesController < ApplicationController
  respond_to :json

  def show
    @address = Address.geocode("#{params[:address]}, #{params[:city_state]}")
    if @address.blank?
      render(json: {errors: {address: [t('errors.not_found', thing: t('defaults.address'))]}}, status: 404)
    else
      respond_with @address
    end
  end
end
