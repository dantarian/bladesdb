class CreateDebriefs < ActiveRecord::Migration[4.2]
  def self.up
    create_table :debriefs do |t|
      t.references :game, :null => false
      t.references :user, :null => false
      t.references :character, :null => true
      t.integer :base_points, :null => true
      t.integer :points_modifier, :null => true
      t.text :remarks, :null => true
      t.integer :money_modifier, :null => true
      t.integer :deaths, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :debriefs
  end
end
