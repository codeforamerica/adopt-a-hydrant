class PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])
    if resource.errors.empty?
      render(:json => {"success" => true})
    else
      render(:json => {"errors" => resource.errors}, :status => 500)
    end
  end

  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
    render("edit", :layout => "info_window")
  end

  def update
    self.resource = resource_class.reset_password_by_token(params[resource_name])
    redirect_to(:controller => "main", :action => "index")
  end
end