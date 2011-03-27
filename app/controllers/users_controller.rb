class UsersController < Devise::RegistrationsController
  def edit
    render_with_scope :edit
  end

  def update
    if resource.update_with_password(params[resource_name])
      sign_in resource_name, resource, :bypass => true
      redirect_to :controller => "hydrants", :action => "show", :hydrant_id => params[:hydrant_id]
    else
      clean_up_passwords(resource)
      render(:json => {"errors" => resource.errors})
    end
  end

  def create
    build_resource
    if resource.save
      if resource.active?
        sign_in(resource_name, resource)
      else
        expire_session_data_after_sign_in!
      end
      render(:json => resource)
    else
      clean_up_passwords(resource)
      render(:json => {"errors" => resource.errors})
    end
  end
end
