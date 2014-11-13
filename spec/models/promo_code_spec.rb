# == Schema Information
#
# Table name: promo_codes
#
#  id              :integer          not null, primary key
#  created_at      :datetime
#  updated_at      :datetime
#  promo_vendor_id :integer
#  token           :string(255)
#  user_id         :integer
#

require 'rails_helper'

RSpec.describe PromoCode, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
