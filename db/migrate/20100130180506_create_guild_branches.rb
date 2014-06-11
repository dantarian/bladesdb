class CreateGuildBranches < ActiveRecord::Migration
  def self.up
    create_table :guild_branches do |t|
      t.string :name, :null => false
      t.references :guild, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :guild_branches
  end
end
