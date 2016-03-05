class AddCommentToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :comment, :string
  end
end
