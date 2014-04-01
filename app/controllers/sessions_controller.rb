class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:destroy]

  def new
    redirect_to(root_path)
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource
      sign_in(resource_name, resource)
      yield resource if block_given?
      render(json: resource)
    else
      render(json: {errors: {password: [t('errors.password')]}}, status: 401)
    end
  end

  def destroy
    signed_in = signed_in?(resource_name)
    sign_out(resource_name) if signed_in
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    yield resource if block_given?
    render(json: {success: signed_in})
  end
end
