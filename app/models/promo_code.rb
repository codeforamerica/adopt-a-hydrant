class PromoCode < ActiveRecord::Base
    include Tokenable
    belongs_to :promo_vendor
end
