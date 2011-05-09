class SessionsController < Devise::SessionsController
  def new
    render("new", :layout => "info_window")
  end

  def create
    resource = warden.authenticate(:scope => resource_name)
    if resource
      sign_in(resource_name, resource)
      render(:json => resource)
    else
      render(:json => {"errors" => {:password => ["You need to sign in or sign up before continuing."]}}, :status => 401)
    end
  end

  def destroy
    signed_in = signed_in?(resource_name)
    sign_out(resource_name) if signed_in
    render(:json => {"success" => signed_in})
  end
end
