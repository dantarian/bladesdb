class CreateDeathThresholdAdjustments < ActiveRecord::Migration
  def self.up
    create_table :death_threshold_adjustments do |t|
      t.references :character, :null => false
      t.integer :change, :null => false
      t.string :reason, :null => false
      t.datetime :declared_at, :null => false
      t.references :approved_by, :null => true
      t.datetime :approved_at, :null => true
      t.boolean :approved, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :death_threshold_adjustments
  end
end
