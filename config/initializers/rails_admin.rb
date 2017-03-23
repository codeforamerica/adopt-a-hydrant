RailsAdmin.config do |config|
  config.authenticate_with do
    redirect_to(main_app.root_path, flash: {warning: 'You must be signed-in as an administrator to access that page'}) unless signed_in? && current_user.admin?
  end

  config.model 'Thing' do
    label I18n.t('defaults.thing')

    configure :created_at do
      label 'Drain Import Date'
    end

    configure :city_id do
      label 'Maximo ID'
    end
  end

  config.model 'User' do
    configure :created_at do
      label 'Account Creation Date'
    end

    configure :updated_at do
      label 'Last Login'
    end
  end
end
