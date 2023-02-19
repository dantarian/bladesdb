class AddCommentToCharacterPointAdjustments < ActiveRecord::Migration[4.2]
  def change
    add_column :character_point_adjustments, :comment, :string
  end
end
