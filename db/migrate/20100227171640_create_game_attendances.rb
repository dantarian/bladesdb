class CreateGameAttendances < ActiveRecord::Migration
    def self.up
        create_table :game_attendances do |t|
            t.references :game, :null => false
            t.references :user, :null => false
            t.boolean :want_food, :null => true
            t.references :food_option, :null => true
            t.references :character, :null => true
            t.string :attend_state, :null => false
            t.string :confirm_state, :null => true

            t.timestamps
        end
    end

    def self.down
        drop_table :game_attendances
    end
end
