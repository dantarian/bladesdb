class AddBranchTitleToGuildBranches < ActiveRecord::Migration
  def change
    add_column :guild_branches, :branch_title, :string
  end
end
