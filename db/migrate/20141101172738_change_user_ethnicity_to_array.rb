class ChangeUserEthnicityToArray < ActiveRecord::Migration
  def change
    change_column :users, :ethnicity, "varchar[] USING (string_to_array(ethnicity, ','))"
  end
end
