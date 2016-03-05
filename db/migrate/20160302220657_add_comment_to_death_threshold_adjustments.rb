class AddCommentToDeathThresholdAdjustments < ActiveRecord::Migration
  def change
    add_column :death_threshold_adjustments, :comment, :string
  end
end
