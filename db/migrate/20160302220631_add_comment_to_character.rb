class AddCommentToCharacter < ActiveRecord::Migration[4.2]
  def change
    add_column :characters, :comment, :string
  end
end
