class AddLootToDebriefs < ActiveRecord::Migration
  def change
    add_column :debriefs, :loot, :integer
  end
end
