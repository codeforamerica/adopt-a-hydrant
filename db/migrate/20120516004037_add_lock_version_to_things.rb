# http://api.rubyonrails.org/classes/ActiveRecord/Migration.html
# http://railscasts.com/episodes/59-optimistic-locking
class AddLockVersionToThings < ActiveRecord::Migration
  def change
    add_column :things, :lock_version, :integer, :default => 0, :null => false
  end
end