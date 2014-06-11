class CreateGamesMasters < ActiveRecord::Migration
  def self.up
    create_table :games_masters, :id => false do |t|
      t.references :game, :null => false
      t.references :user, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :games_masters
  end
end
