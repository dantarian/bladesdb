class AddGmNotesToCharacter < ActiveRecord::Migration
    def self.up
        add_column :characters, :gm_notes, :text, :null => true
    end

    def self.down
        remove_column :characters, :gm_notes
    end
end
