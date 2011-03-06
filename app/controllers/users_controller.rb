class UsersController < ApplicationController
  def sign_up
    @data = {"email" => params[:email], "name" => params[:name]}
    respond_to do |format|
      format.json{render :json => @data}
    end
  end

  def sign_in
    @data = {"email" => params[:email]}
    respond_to do |format|
      format.json{render :json => @data}
    end
  end

  def forgot_password
    @data = {"email" => params[:email]}
    respond_to do |format|
      format.json{render :json => @data}
    end
  end
end
