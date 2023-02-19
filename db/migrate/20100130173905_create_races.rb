class CreateRaces < ActiveRecord::Migration[4.2]
  def self.up
    create_table :races do |t|
      t.string :name, :null => false
      t.integer :death_thresholds, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :races
  end
end
