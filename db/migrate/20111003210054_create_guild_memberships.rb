class CreateGuildMemberships < ActiveRecord::Migration
  def self.up
    create_table :guild_memberships do |t|
      t.references :character
      t.references :guild
      t.references :guild_branch
      t.boolean :provisional
      t.date :declared_on
      t.integer :start_points
      t.boolean :approved
      t.datetime :approved_at
      t.references :approved_by

      t.timestamps
    end
  end

  def self.down
    drop_table :guild_memberships
  end
end
