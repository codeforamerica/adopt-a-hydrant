# http://www.dzone.com/snippets/ruby-open-file-write-it-and
# http://www.ruby-doc.org/core-1.9.3/Hash.html
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_flash_from_params
  before_filter :set_locale

protected

  def set_flash_from_params
    if params[:flash]
      params[:flash].each do |key, message|
        if message.include? 'notices'
          flash.now[key.to_sym] = I18n.t(message)
        else
          flash.now[key.to_sym] = message
        end
      end
    end
  end

  def set_locale
    # reset_session
    available_languages = Dir.glob(Rails.root + "config/locales/??.yml").map do |file|
      File.basename(file, ".yml")
    end
    cookies[:locale] = params[:locale]  if ((params[:locale] == 'cn') || (params[:locale] == 'de') || (params[:locale] == 'en') || (params[:locale] == 'es') || (params[:locale] == 'fr') || (params[:locale] == 'ht') || (params[:locale] == 'it') || (params[:locale] == 'kr') || (params[:locale] == 'pl') || (params[:locale] == 'pt') || (params[:locale] == 'ru') || (params[:locale] == 'yi'))
    I18n.locale = cookies[:locale] || I18n.default_locale
  end
end