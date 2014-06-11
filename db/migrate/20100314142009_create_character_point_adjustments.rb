class CreateCharacterPointAdjustments < ActiveRecord::Migration
    def self.up
        create_table :character_point_adjustments do |t|
            t.references :character, :null => false
            t.integer :points, :null => false
            t.string :reason, :null => false
            t.datetime :declared_at, :null => false
            t.references :approved_by
            t.datetime :approved_at
            t.boolean :approved

            t.timestamps
        end
    end

    def self.down
        drop_table :character_point_adjustments
    end
end
