RailsAdmin.config do |config|
  config.authenticate_with do
    redirect_to(main_app.root_path, flash: {warning: 'You must be signed-in as an administrator to access that page'}) unless signed_in? && current_user.admin?
  end
end
