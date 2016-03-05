class AddCommentToCharacterPointAdjustments < ActiveRecord::Migration
  def change
    add_column :character_point_adjustments, :comment, :string
  end
end
