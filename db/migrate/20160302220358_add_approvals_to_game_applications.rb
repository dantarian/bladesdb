class AddApprovalsToGameApplications < ActiveRecord::Migration
  def change
    add_column :game_applications, :approved, :boolean
    add_column :game_applications, :comment, :string
  end
end
