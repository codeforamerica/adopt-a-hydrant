# == Schema Information
#
# Table name: promo_vendors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class PromoVendor < ActiveRecord::Base
    has_many :promo_codes
end
