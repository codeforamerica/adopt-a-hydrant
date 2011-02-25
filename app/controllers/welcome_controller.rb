class WelcomeController < ApplicationController
  def index
    # Default coordinates: Boston center
    @lat, @lng = 42.358431, -71.059773
    @zoom = 15
    address, city, state = params[:address], params[:city], params[:state]
    if address && city && state
      @lat, @lng = Address.find_lat_lng("#{address}, #{city}, #{state}")
      @zoom = 18
    end
  end
end
