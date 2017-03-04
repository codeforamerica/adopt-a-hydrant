class ChangeColName < ActiveRecord::Migration
  def change
    rename_column :things, :created_at, :drain_import_date
    rename_column :users, :created_at, :account_creation_date
    rename_column :users, :updated_at, :last_login
  end
end
