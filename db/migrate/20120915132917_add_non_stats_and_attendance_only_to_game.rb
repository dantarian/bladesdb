class AddNonStatsAndAttendanceOnlyToGame < ActiveRecord::Migration[4.2]
    def self.up
        add_column :games, :non_stats, :boolean, :default => false, :null => false
        add_column :games, :attendance_only, :boolean, :default => false, :null => false
    end

    def self.down
        remove_column :games, :non_stats
        remove_column :games, :attendance_only
    end
end
