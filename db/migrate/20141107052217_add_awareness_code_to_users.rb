class AddAwarenessCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :awareness_code, :string
  end
end
