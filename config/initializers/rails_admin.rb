RailsAdmin.config do |config|
  config.authenticate_with do
    redirect_to '/' unless signed_in? && current_user.admin?
  end
end
