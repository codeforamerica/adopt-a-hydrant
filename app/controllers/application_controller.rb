class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_flash_from_params
  before_action :set_locale

protected

  def set_flash_from_params
    params.fetch(:flash, []).each do |key, message|
      flash.now[key.to_sym] = message
    end
  end

  def set_locale
    available_languages = Dir.glob(Rails.root + 'config/locales/??.yml').collect do |file|
      File.basename(file, '.yml')
    end
    I18n.locale = http_accept_language.compatible_language_from(available_languages) || I18n.default_locale
  end
end
