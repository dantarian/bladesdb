class CreateDebits < ActiveRecord::Migration
    def self.up
        create_table :debits do |t|
            t.references :transaction, :null => false
            t.references :character, :null => true
            t.string :other_source, :null => true

            t.timestamps
        end
    end

    def self.down
        drop_table :debits
    end
end
