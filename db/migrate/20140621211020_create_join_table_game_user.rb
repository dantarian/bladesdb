class CreateJoinTableGameUser < ActiveRecord::Migration[4.2]
  def change
    create_join_table :games, :users, { table_name: "caterers" } do |t|
      t.index [:game_id, :user_id]
    end
  end
end
