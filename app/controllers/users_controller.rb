class UsersController < Devise::RegistrationsController
  def edit
    render("sidebar/edit_profile", layout: "sidebar")
  end

  def update
    if resource.update_with_password(resource_params)
      sign_in(resource_name, resource, bypass: true)
      flash[:notice] = "Profile updated!"
      redirect_to(controller: "sidebar", action: "search")
    else
      clean_up_passwords(resource)
      render(json: {errors: resource.errors}, status: 500)
    end
  end

  def create
    build_resource
    if resource.save
      sign_in(resource_name, resource)
      render(json: resource)
    else
      clean_up_passwords(resource)
      render(json: {errors: resource.errors}, status: 500)
    end
  end

private

  def resource_params
    params.require(:user).permit(:address_1, :address_2, :city,
                                 :current_password, :email, :name,
                                 :organization, :password,
                                 :password_confirmation, :remember_me,
                                 :sms_number, :state, :voice_number, :zip)
  end
end
