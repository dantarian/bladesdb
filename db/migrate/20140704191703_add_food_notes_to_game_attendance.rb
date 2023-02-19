class AddFoodNotesToGameAttendance < ActiveRecord::Migration[4.2]
  def change
    add_column :game_attendances, :food_notes, :string
  end
end
