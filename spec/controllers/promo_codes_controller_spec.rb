require 'rails_helper'

RSpec.describe PromoCodesController, :type => :controller do

  let(:promo_code) { create(:promo_code) }
  let(:user) { create(:user) }

  it "should use an existing, unused token" do
    promo_code.user = user

    patch "update", { promo_code: promo_code.attributes }
    promo_code.reload

    expect(response.status).to eq(200)
    expect(promo_code.used?)
    expect(promo_code.user).to eq(user)
  end

  it "should not allow me to use a used token" do
    promo_code.update!(user: user)
    patch "update", { promo_code: promo_code.attributes }

    expect(response.status).to eq(403)
  end

  it "should not allow me to use a token without a user" do
    patch "update", { promo_code: promo_code.attributes }

    expect(response.status).to eq(401)
  end

  it "should not be able to find a non-existant token" do
    promo_code.token = 'foobar'

    patch "update", { promo_code: promo_code.attributes }

    expect(response.status).to eq(404)
  end
end
