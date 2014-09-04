class AddPromoVendorRefToPromoCodes < ActiveRecord::Migration
  def change
    add_reference :promo_codes, :promo_vendor, index: true
  end
end
