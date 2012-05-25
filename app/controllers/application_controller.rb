# http://www.dzone.com/snippets/ruby-open-file-write-it-and
# http://www.ruby-doc.org/core-1.9.3/Hash.html
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_flash_from_params
  before_filter :set_locale

protected

  
  def set_locale
    File.open('app/assets/javascripts/main.js.erb', 'a') {|f| f.write(string = ' ')}
    available_languages = Dir.glob(Rails.root + "config/locales/??.yml").map do |file|
      File.basename(file, ".yml")
    end
    cookies[:locale] = params[:locale]  if ((params[:locale] == 'en') || (params[:locale] == 'de') || (params[:locale] == 'es') || (params[:locale] == 'pt') || (params[:locale] == 'fr'))
    I18n.locale = cookies[:locale] || I18n.default_locale
  end
  
  def set_flash_from_params
    if params[:flash]
      params[:flash].each do |key, message|
        if message.include? 'notices'
          puts 'Hello'
          flash.now[key.to_sym] = I18n.t(message)
        else
          flash.now[key.to_sym] = message
        end
      end
    end
  end
end