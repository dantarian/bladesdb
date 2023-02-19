class CreateGameApplications < ActiveRecord::Migration[4.2]
  def self.up
    create_table :game_applications do |t|
      t.references :game, :null => false
      t.references :user, :null => false
      t.text :details, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :game_applications
  end
end
