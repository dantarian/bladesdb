class CreateCharacters < ActiveRecord::Migration[4.2]
  def self.up
    create_table :characters do |t|
      t.references :user, :null => false
      t.string :name, :null => false
      t.references :race, :null => false
      t.references :guild, :null => true
      t.integer :guild_start_points, :null => true
      t.integer :starting_points, :null => false, :default => 20
      t.integer :starting_florins, :null => false, :default => 0
      t.integer :starting_death_thresholds, :null => false
      t.text :biography, :null => true
      t.date :date_of_birth, :null => true
      t.boolean :date_of_birth_public, :null => true
      t.text :address, :null => true
      t.string :title, :null => true
      t.string :state, :null => false, :default => 'active'
      t.text :notes, :null => true
      t.date :declared_on, :null => false, :default => Date.today
      t.references :approved_by, :null => true
      t.date :approved_on, :null => true
      t.boolean :approved, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
