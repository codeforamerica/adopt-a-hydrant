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

class PromoCode < ActiveRecord::Base
    include Tokenable
    belongs_to :promo_vendor
    belongs_to :user

    validates :token, uniqueness: true

    def used?
      return !self.user.nil?
    end
end
