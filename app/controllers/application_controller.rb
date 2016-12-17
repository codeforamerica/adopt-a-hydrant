class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_flash_from_params
  before_action :set_locale

  force_ssl if: :ssl_configured?

protected

  def require_admin
    return if user_signed_in? && current_user.admin?

    flash[:error] = 'You must be an admin'
    redirect_to root_path
  end

  def set_flash_from_params
    params.fetch(:flash, []).each do |key, message|
      flash.now[key.to_sym] = message
    end
  end

  def set_locale
    I18n.locale = :en
  end

  def ssl_configured?
    Rails.env.production?
  end
end
