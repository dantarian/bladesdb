class AddCommentToMonsterPointAdjustments < ActiveRecord::Migration[4.2]
  def change
    add_column :monster_point_adjustments, :comment, :string
  end
end
