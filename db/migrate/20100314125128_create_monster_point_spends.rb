class CreateMonsterPointSpends < ActiveRecord::Migration[4.2]
  def self.up
    create_table :monster_point_spends do |t|
      t.references :character
      t.integer :monster_points_spent
      t.date :spent_on
      t.integer :character_points_gained

      t.timestamps
    end
  end

  def self.down
    drop_table :monster_point_spends
  end
end
