class PasswordsController < Devise::PasswordsController
  respond_to :json, :only => [:create, :update]

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])

    if resource.errors.empty?
      render(:json => {"success" => true})
    else
      render(:json => {"errors" => resource.errors})
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
    render_with_scope :edit
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(params[resource_name])

    if resource.errors.empty?
      render(:json => {"success" => true})
    else
      render(:json => {"errors" => resource.errors})
    end
  end
end
