class AddTokenToPromoCodes < ActiveRecord::Migration
  def change
    add_column :promo_codes, :token, :string
  end
end
