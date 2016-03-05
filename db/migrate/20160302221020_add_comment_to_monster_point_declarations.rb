class AddCommentToMonsterPointDeclarations < ActiveRecord::Migration
  def change
    add_column :monster_point_declarations, :comment, :string
  end
end
