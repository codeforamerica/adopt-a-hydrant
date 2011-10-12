RailsAdmin.config do |config|
  config.authenticate_with do
    redirect_to main_app_root_path unless signed_in? && current_user.admin?
  end
end
