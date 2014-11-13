# == Schema Information
#
# Table name: things
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  user_id     :integer
#  mpls_id     :integer
#  mpls_unique :string(255)
#  lat         :decimal(32, 29)  not null
#  lng         :decimal(32, 29)  not null
#  species     :string(255)
#  properties  :json
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Thing, :type => :model do
  it "is valid with a lat, and lng" do
    thing = build(:thing)

    expect(thing).to be_valid
  end

  it "is invalid without a lat" do
    thing = build(:thing, lat: nil)

    expect(thing).to_not be_valid
    expect(thing.errors[:lat].count).to eq 1
  end

  it "is invalid without a lng" do
    thing = build(:thing, lng: nil)

    expect(thing).to_not be_valid
    expect(thing.errors[:lng].count).to eq 1
  end
end
