class ChangeDefaultOpenOnGames < ActiveRecord::Migration
  def change
    change_column_default :games, :open, from: true, to: false
  end
end
