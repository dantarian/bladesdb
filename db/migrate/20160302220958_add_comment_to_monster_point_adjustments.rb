class AddCommentToMonsterPointAdjustments < ActiveRecord::Migration
  def change
    add_column :monster_point_adjustments, :comment, :string
  end
end
