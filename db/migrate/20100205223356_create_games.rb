class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :title, :null => true
      t.integer :lower_rank, :null => true
      t.integer :upper_rank, :null => true
      t.text :ic_brief, :null => true
      t.text :ooc_brief, :null => true
      t.text :ic_debrief, :null => true
      t.text :ooc_debrief, :null => true
      t.integer :player_points_base, :null => true
      t.integer :player_money_base, :null => true
      t.integer :monster_points_base, :null => true
      t.date :start_date, :null => false
      t.date :end_date, :null => true
      t.time :meet_time, :null => true
      t.time :start_time, :null => true
      t.boolean :food, :null => false, :default => false
      t.boolean :open, :null => false, :default => true
      t.string :notes, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
