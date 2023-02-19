class CreateBoardVisits < ActiveRecord::Migration[4.2]
  def self.up
    create_table :board_visits do |t|
      t.references :board, :null => false
      t.references :user, :null => false
      t.datetime :last_visit, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :board_visits
  end
end
