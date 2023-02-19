class AddLootToDebriefs < ActiveRecord::Migration[4.2]
  def change
    add_column :debriefs, :loot, :integer
  end
end
