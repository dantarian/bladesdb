class RemoveFoodFromGameAttendances < ActiveRecord::Migration[4.2]
    def change
      remove_column :game_attendances, :food_option_id, :integer
    end
end
