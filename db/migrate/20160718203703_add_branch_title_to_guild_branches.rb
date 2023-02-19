class AddBranchTitleToGuildBranches < ActiveRecord::Migration[4.2]
  def change
    add_column :guild_branches, :branch_title, :string
  end
end
