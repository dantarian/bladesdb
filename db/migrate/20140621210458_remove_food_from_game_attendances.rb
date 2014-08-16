class RemoveFoodFromGameAttendances < ActiveRecord::Migration
    def change
      remove_column :game_attendances, :food_option_id, :integer
    end
end
