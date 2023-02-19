class AddTitheToGuilds < ActiveRecord::Migration[4.2]
  def self.up
    change_table :guilds do |t|
      t.integer :tithe_percentage
      t.boolean :proscribed
    end
  end

  def self.down
    change_table :guilds do |t|
      t.remove :tithe_percentage, :proscribed
    end
  end
end
