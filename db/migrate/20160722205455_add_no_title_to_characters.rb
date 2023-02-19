class AddNoTitleToCharacters < ActiveRecord::Migration[4.2]
  def change
    add_column :characters, :no_title, :boolean, null: false, default: false
  end
end
