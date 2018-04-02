# frozen_string_literal: true

class AddSystemUseCodeToThings < ActiveRecord::Migration
  def change
    add_column :things, :system_use_code, :string
  end
end
