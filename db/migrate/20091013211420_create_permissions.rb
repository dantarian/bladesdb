class CreatePermissions < ActiveRecord::Migration[4.2]
    def self.up
        create_table :permissions do |t|
            t.references :role, :null => false
            t.references :user, :null => false
            t.timestamps
        end
    end

    def self.down
        drop_table :permissions
    end
end
