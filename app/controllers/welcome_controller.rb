class WelcomeController < ApplicationController
  def index
    @zoom = 15
    # Default coordinates: Boston center
    @lat, @lng = 42.358431, -71.059773
    @hydrants = []
    address, city, state = params[:address], params[:city], params[:state]
    if address && city && state
      @zoom = 18
      @lat, @lng = Address.find_lat_lng("#{address}, #{city}, #{state}")
      @hydrants = Hydrant.find_closest(@lat, @lng)
    end
  end
end
