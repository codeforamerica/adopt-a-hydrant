class AddParkQuestionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :yob, :integer
    add_column :users, :gender, :string
    add_column :users, :ethnicity, :string
    add_column :users, :yearsInMinneapolis, :integer
    add_column :users, :rentOrOwn, :string
    add_column :users, :previousTreeWateringExperience, :boolean
    add_column :users, :previousEnvironmentalActivities, :boolean
    add_column :users, :valueForestryWork, :integer
    add_column :users, :heardOfAdoptATreeVia, :string
  end
end
