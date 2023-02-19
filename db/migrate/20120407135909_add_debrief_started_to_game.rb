class AddDebriefStartedToGame < ActiveRecord::Migration[4.2]
    def self.up
        add_column :games, :debrief_started, :boolean, :default => false, :null => false
    end

    def self.down
        remove_column :games, :debrief_started
    end
end
