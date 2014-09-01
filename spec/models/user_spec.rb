require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with a name, email and password" do
    user = build(:user)

    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = build(:user, name: nil)

    expect(user).to_not be_valid
    expect(user.errors[:name].count).to eq 1
  end

  it "is invalide with an invalid email" do
    user = build(:user, email: 'invalid@example')

    expect(user).to_not be_valid
    expect(user.errors[:email].count).to eq 1
  end

  it "is invalide without an email" do
    user = build(:user, email: nil)

    expect(user).to_not be_valid
    expect(user.errors[:email].count).to eq 2
  end

  it "is invalid without a password" do
    user = build(:user, password: nil)

    expect(user).to_not be_valid
    expect(user.errors[:password].count).to eq 1
  end

  it "is invalid with a password length of 7" do
    user = build(:user, password: 'aaaaaaa')

    expect(user).to_not be_valid
    expect(user.errors[:password].count).to eq 1
  end

  it "is invalid with a password length of 129" do
    user = build(:user, password: 'a' * 129)

    expect(user).to_not be_valid
    expect(user.errors[:password].count).to eq 1
  end

  it "removes non-digits from voice number" do
    user = build(:user, voice_number: '555-555-5555')

    expect(user).to be_valid
    expect(user.voice_number).to eq 5555555555
  end

  it "removes non-digits from sms number" do
    user = build(:user, sms_number: '(555) 555-5555')

    expect(user).to be_valid
    expect(user.sms_number).to eq 5555555555
  end

  it "is invalid with an invalid sms number" do
    user = build(:user, sms_number: '1-555-555-5555')

    expect(user).to_not be_valid
    expect(user.errors[:sms_number].count).to eq 1
  end

  it "is invalid with an invalid voice number" do
    user = build(:user, voice_number: '1-555-555-5555')

    expect(user).to_not be_valid
    expect(user.errors[:voice_number].count).to eq 1
  end

end
