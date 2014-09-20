class AddClosedToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :closed, :boolean, null: false, default: false
  end
end
