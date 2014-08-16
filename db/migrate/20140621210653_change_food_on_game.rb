class ChangeFoodOnGame < ActiveRecord::Migration
  def change
    remove_column :games, :food, :boolean
    add_column :games, :food_notes, :string
    add_column :games, :food_cutoff, :datetime
  end
end
