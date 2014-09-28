require 'rails_helper'

RSpec.describe PromoCodesController, :type => :controller do

  before(:each) do
    @pc = PromoCode.new
    @pc.save
    @user = User.new(:email => 'aperson@gmail.com', :password=>'password', :name=>'A Person')
    @user.save
    @params = {
        :token => @pc.token, 
        :user_id => @user.id}
    @request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
  end

  it "should use an existing, unused token" do
    patch "update", {:promo_code => @params}, @request_headers
    expect(response).to be_success
    @pc.reload
    expect(@pc.used?).to be_truthy
    expect(@pc.user).to eq(@user)
  end

  it "should not allow me to use a used token" do
    @pc.user = @user
    @pc.save
    patch "update", {:promo_code => @params}, @request_headers
    expect(response.status).to eq(422)
  end

  it "should not allow me to use a token without a user" do
    @params.delete(:user_id)
    patch "update", {:promo_code => @params}, @request_headers
    expect(response.status).to eq(401)
  end

  it "should not be able to find a non-existant token" do
    @params['token'] = 'foobar'
    patch "update", {:promo_code => @params}, @request_headers
    expect(response.status).to eq(404)
  end


  after(:each) do
    @pc.destroy
    @user.destroy
  end

end
