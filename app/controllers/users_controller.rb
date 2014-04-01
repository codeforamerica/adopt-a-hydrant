class UsersController < Devise::RegistrationsController
  def edit
    render('sidebar/edit_profile', layout: 'sidebar')
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    if update_resource(resource, account_update_params)
      yield resource if block_given?
      sign_in(resource_name, resource, bypass: true)
      flash[:notice] = 'Profile updated!'
      redirect_to(controller: 'sidebar', action: 'search')
    else
      clean_up_passwords(resource)
      render(json: {errors: resource.errors}, status: 500)
    end
  end

  def create
    build_resource(sign_up_params)
    if resource.save
      yield resource if block_given?
      sign_in(resource_name, resource)
      render(json: resource)
    else
      clean_up_passwords(resource)
      render(json: {errors: resource.errors}, status: 500)
    end
  end

private

  def sign_up_params
    params.require(:user).permit(:email, :name, :organization, :password, :password_confirmation, :sms_number, :voice_number)
  end

  def account_update_params
    params.require(:user).permit(:address_1, :address_2, :city, :current_password, :email, :name, :organization, :password, :password_confirmation, :remember_me, :sms_number, :state, :voice_number, :zip)
  end
end
