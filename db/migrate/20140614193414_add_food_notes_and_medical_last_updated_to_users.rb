class AddFoodNotesAndMedicalLastUpdatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :food_notes, :string
    add_column :users, :emergency_last_updated, :datetime
  end
end
