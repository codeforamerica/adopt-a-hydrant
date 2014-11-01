class ConvertHeardOfToAnArray < ActiveRecord::Migration
  def change
    change_column :users, :heardOfAdoptATreeVia, "varchar[] USING (string_to_array(\"heardOfAdoptATreeVia\", ','))"
  end
end
