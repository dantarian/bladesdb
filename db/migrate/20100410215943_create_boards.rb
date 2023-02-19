class CreateBoards < ActiveRecord::Migration[4.2]
  def self.up
    create_table :boards do |t|
      t.string :name, :null => false
      t.boolean :in_character, :null => false, :default => false
      t.text :blurb, :null => true
      t.integer :order, :null => false
      t.references :campaign, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :boards
  end
end
