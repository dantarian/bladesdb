class AddPlayerNotesAndPreferredCharacterToCharacters < ActiveRecord::Migration[4.2]
  def change
    add_column :characters, :player_notes, :text
    add_column :characters, :preferred_character, :boolean, null: false, default: false
  end
end
