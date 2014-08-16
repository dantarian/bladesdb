class AddFoodNotesToGameAttendance < ActiveRecord::Migration
  def change
    add_column :game_attendances, :food_notes, :string
  end
end
