class AddCommentToGuildMembership < ActiveRecord::Migration[4.2]
  def change
    add_column :guild_memberships, :comment, :string
  end
end
