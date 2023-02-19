class CreateMonsterPointAdjustments < ActiveRecord::Migration[4.2]
  def self.up
    create_table :monster_point_adjustments do |t|
      t.references :user, :null => false
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
    drop_table :monster_point_adjustments
  end
end
