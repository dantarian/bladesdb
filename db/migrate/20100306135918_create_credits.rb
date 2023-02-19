class CreateCredits < ActiveRecord::Migration[4.2]
    def self.up
        create_table :credits do |t|
            t.references :transaction, :null => false
            t.references :character, :null => true
            t.string :other_recipient, :null => true

            t.timestamps
        end
    end

    def self.down
        drop_table :credits
    end
end
