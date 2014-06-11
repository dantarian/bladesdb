class ExtendUser < ActiveRecord::Migration
    def self.up
        change_table :users do |t|
            t.string :password_reset_code, :limit => 40
            t.boolean :is_admin, :default => false, :null => false
            t.timestamp :last_login, :null => true
            t.integer :starting_monster_points, :default => 0, :null => true
            t.timestamp :monster_points_declared_at, :null => true
            t.string :mobile_number, :null => true
        end
    end

    def self.down
        change_table :users do |t|
            t.remove    :password_reset_code, 
                        :is_admin, 
                        :last_login, 
                        :starting_monster_points, 
                        :monster_points_declared_at, 
                        :mobile_number
        end
    end
end
