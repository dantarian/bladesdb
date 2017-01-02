class AddNoTitleToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :no_title, :boolean, null: false, default: false
  end
end
