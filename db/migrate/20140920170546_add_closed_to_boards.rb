class AddClosedToBoards < ActiveRecord::Migration[4.2]
  def change
    add_column :boards, :closed, :boolean, null: false, default: false
  end
end
