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

  def survey
    @user = current_user
    render('survey', layout: nil)
  end

  def mailing_address
    @user = current_user
    render('mailing_address', layout: nil)
  end

  def restricted_update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    if resource.update(restricted_account_update_params)
      yield resource if block_given?
      flash[:notice] = 'Profile updated!'
      render(json: {}, status: 204)
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
    params.require(:user).permit(:address_1, :address_2, :city, :email,  :first_name, :last_name, :organization, :password, :password_confirmation, :sms_number, :state, :voice_number, :username, :zip)
  end

  def account_update_params
    params.require(:user).permit(:address_1, :address_2, :city, :current_password, :email, :gender, :username, :first_name, :last_name, :organization, :password, :password_confirmation, :previousEnvironmentalActivities, :previousTreeWateringExperience, :remember_me, :rentOrOwn, :sms_number, :state, :valueForestryWork, :voice_number, :yearsInMinneapolis, :yob, :zip, :ethnicity => [], :heardOfAdoptATreeVia => [])
  end

  def restricted_account_update_params
    params.require(:user).permit(:address_1, :address_2, :city, :gender, :username, :first_name, :last_name, :organization, :previousEnvironmentalActivities, :previousTreeWateringExperience, :rentOrOwn, :sms_number, :state, :valueForestryWork, :voice_number, :yearsInMinneapolis, :yob, :zip, :ethnicity => [], :heardOfAdoptATreeVia => [])
  end
end
