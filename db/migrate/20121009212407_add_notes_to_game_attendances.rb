class AddNotesToGameAttendances < ActiveRecord::Migration[4.2]
  def self.up
    add_column :game_attendances, :notes, :string
  end

  def self.down
    remove_column :game_attendances, :notes
  end
end
