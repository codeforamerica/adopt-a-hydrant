class SessionsController < Devise::SessionsController
  def new
    redirect_to root_path
  end

  def create
    resource = warden.authenticate(:scope => resource_name)
    if resource
      sign_in(resource_name, resource)
      render(:json => resource)
    else
      render(:json => {"errors" => {:password => [t("errors.password")]}}, :status => 401)
    end
  end

  def destroy
    signed_in = signed_in?(resource_name)
    sign_out(resource_name) if signed_in
    render(:json => {"success" => signed_in})
  end
end
