class CreateMonsterPointDeclarations < ActiveRecord::Migration[4.2]
  def self.up
    create_table :monster_point_declarations do |t|
      t.references :user, :null => false
      t.integer :points, :null => false
      t.datetime :declared_at, :null => false
      t.references :approved_by, :null => true
      t.datetime :approved_at, :null => true
      t.boolean :approved, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :monster_point_declarations
  end
end
