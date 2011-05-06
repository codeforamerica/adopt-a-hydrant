class UsersController < Devise::RegistrationsController
  respond_to :json, :only => [:create]

  def edit
    render("edit", :layout => "info_window")
  end

  def update
    if resource.update_with_password(params[resource_name])
      sign_in(resource_name, resource, :bypass => true)
      redirect_to(:controller => "hydrants", :action => "show", :hydrant_id => params[:hydrant_id])
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
      respond_with resource
    else
      clean_up_passwords(resource)
      render(:json => {"errors" => resource.errors})
    end
  end
end
