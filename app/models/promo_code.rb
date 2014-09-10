class PromoCode < ActiveRecord::Base
    include Tokenable
    belongs_to :promo_vendor
    belongs_to :user

    def used?
      return !self.user.nil?
    end
end
