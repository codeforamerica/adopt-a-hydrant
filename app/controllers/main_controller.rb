class MainController < ApplicationController
  def index
    @zoom = 15
    # Default coordinates: Boston center
    @lat, @lng = 42.358431, -71.059773
    @hydrants = []
    address, city_state = params[:address], params[:city_state]
    if address && city_state
      @zoom = 18
      @lat, @lng = Address.find_lat_lng("#{address}, #{city_state}")
      @hydrants = Hydrant.find_closest(@lat, @lng)
    end
  end

  def sign_up
    @data = {"email" => params[:email], "name" => params[:name]}
    respond_to do |format|
      format.json{render :json => @data}
    end
  end

  def sign_in
    @data = {"email" => params[:email]}
    respond_to do |format|
      format.json{render :json => @data}
    end
  end

  def forgot_password
    @data = {"email" => params[:email]}
    respond_to do |format|
      format.json{render :json => @data}
    end
  end
end
