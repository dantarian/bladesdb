class CreateFoodOptions < ActiveRecord::Migration[4.2]
  def self.up
    create_table :food_options do |t|
      t.references :game, :null => false
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :food_options
  end
end
