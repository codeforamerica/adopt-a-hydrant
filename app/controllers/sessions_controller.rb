class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    resource = warden.authenticate(:scope => resource_name)
    sign_in(resource_name, resource)
    respond_with resource
  end

  def destroy
    signed_in = signed_in?(resource_name)
    sign_out(resource_name) if signed_in
    respond_with signed_in
  end
end
