class UsersController < Devise::RegistrationsController
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
      sign_in(resource_name, resource)
      render(:json => resource)
    else
      clean_up_passwords(resource)
      render(:json => {"errors" => resource.errors})
    end
  end
end
