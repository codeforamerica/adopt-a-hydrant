class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    resource = warden.authenticate(:scope => resource_name)
    if resource
      sign_in(resource_name, resource)
      respond_with resource
    else
      render(:json => {"errors" => {:password => ["You need to sign in or sign up before continuing."]}})
    end
  end

  def destroy
    signed_in = signed_in?(resource_name)
    sign_out(resource_name) if signed_in
    render(:json => {"success" => signed_in})
  end
end
