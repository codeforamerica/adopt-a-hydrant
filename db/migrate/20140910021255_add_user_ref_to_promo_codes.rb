class AddUserRefToPromoCodes < ActiveRecord::Migration
  def change
    add_reference :promo_codes, :user, index: true
  end
end
