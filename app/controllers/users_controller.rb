class UsersController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource
    if resource.save
      if resource.active?
        sign_in(resource_name, resource)
      else
        expire_session_data_after_sign_in!
      end
      respond_with resource
    else
      clean_up_passwords(resource)
      render(:json => {"errors" => resource.errors})
    end
  end
end
