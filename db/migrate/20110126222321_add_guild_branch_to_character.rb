class AddGuildBranchToCharacter < ActiveRecord::Migration[4.2]
    def self.up
        add_column :characters, :branch_id, :integer, :null => true
    end

    def self.down
        remove_column :characters, :branch_id
    end
end
