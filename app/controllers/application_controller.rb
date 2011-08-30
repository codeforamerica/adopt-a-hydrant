class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_flash_from_params

protected

  def set_flash_from_params
    if params[:flash]
      params[:flash].each do |key, message|
        flash.now[key.to_sym] = message
      end
    end
  end
end
