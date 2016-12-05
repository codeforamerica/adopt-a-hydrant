class AddDeletedAtToThings < ActiveRecord::Migration
  def change
    add_column :things, :deleted_at, :datetime
    add_index :things, :deleted_at
  end
end
