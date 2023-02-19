class ChangeDefaultOpenOnGames < ActiveRecord::Migration[4.2]
  def change
    change_column_default :games, :open, from: true, to: false
  end
end
