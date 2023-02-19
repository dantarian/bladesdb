class AddCommentToDeathThresholdAdjustments < ActiveRecord::Migration[4.2]
  def change
    add_column :death_threshold_adjustments, :comment, :string
  end
end
