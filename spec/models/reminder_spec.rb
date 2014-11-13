# == Schema Information
#
# Table name: reminders
#
#  id           :integer          not null, primary key
#  thing_id     :integer          not null
#  from_user_id :integer          not null
#  to_user_id   :integer          not null
#  sent         :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Reminder, :type => :model do
  it "is valid with a thing, from_user and to_user" do
    reminder = build(:reminder)

    expect(reminder).to be_valid
  end

  it "is invalid without a thing" do
    reminder = build(:reminder, thing: nil)

    expect(reminder).to_not be_valid
    expect(reminder.errors[:thing].count).to eq 1
  end

  it "is invalid without a from_user" do
    reminder = build(:reminder, from_user: nil)

    expect(reminder).to_not be_valid
    expect(reminder.errors[:from_user].count).to eq 1
  end

  it "is invalid without a to_user" do
    reminder = build(:reminder, to_user: nil)

    expect(reminder).to_not be_valid
    expect(reminder.errors[:to_user].count).to eq 1
  end
end
