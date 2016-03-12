class AddCommentToGuildMembership < ActiveRecord::Migration
  def change
    add_column :guild_memberships, :comment, :string
  end
end
