class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_flash_from_params
  before_filter :set_locale

protected

  def set_flash_from_params
    if params[:flash]
      params[:flash].each do |key, message|
        flash.now[key.to_sym] = message
      end
    end
  end

  def set_locale
    available_languages = Dir.glob(Rails.root + "config/locales/??.yml").map do |file|
      File.basename(file, ".yml")
    end
    I18n.locale = request.compatible_language_from(available_languages) || I18n.default_locale
  end
end