class CreateTitles < ActiveRecord::Migration
  def self.up
    create_table :titles do |t|
      t.string :name, :null => false
      t.references :guild, :null => false
      t.integer :points, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :titles
  end
end
