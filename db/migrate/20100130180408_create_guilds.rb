class CreateGuilds < ActiveRecord::Migration
  def self.up
    create_table :guilds do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :guilds
  end
end
