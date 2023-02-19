class AddCommentToMonsterPointDeclarations < ActiveRecord::Migration[4.2]
  def change
    add_column :monster_point_declarations, :comment, :string
  end
end
