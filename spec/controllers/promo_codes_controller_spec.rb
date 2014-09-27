require 'rails_helper'

RSpec.describe PromoCodesController, :type => :controller do

  before(:each) do
    @pc = PromoCode.new
    @pc.save
    @user = User.new
    @user.save
  end

  it "should use an existing, unused token" do
    patch :update, token: @pc.token
    expect(response).to be_success
    expect(@pc.used?).to be_true
  end

  it "should not allow me to use a used token" do
    @pc.user = @user
    @pc.save
    patch :update, token: @pc.token
    expect(response).to eq(422)
  end

  it "should not be able to find a non-existant token" do
    patch :update, token: 'foobar'
    expect(response).to eq(404)
  end


  after(:each) do
    @pc.destroy
    @user.destroy
  end

end
