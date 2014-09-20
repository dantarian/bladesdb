class AddPlayerNotesAndPreferredCharacterToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :player_notes, :text
    add_column :characters, :preferred_character, :boolean, null: false, default: false
  end
end
