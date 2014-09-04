class CreatePromoCodes < ActiveRecord::Migration
  def change
    create_table :promo_codes do |t|

      t.timestamps
    end
  end
end
