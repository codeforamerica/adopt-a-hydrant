class AddRememberPasswordSentAtToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.datetime :reset_password_sent_at
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
