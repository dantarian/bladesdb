class AddNotesToGameAttendances < ActiveRecord::Migration
  def self.up
    add_column :game_attendances, :notes, :string
  end

  def self.down
    remove_column :game_attendances, :notes
  end
end
