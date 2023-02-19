class CreateCampaignsGames < ActiveRecord::Migration[4.2]
    def self.up
      create_table :campaigns_games, :id => false do |t|
        t.references :campaign, :null => false
        t.references :game, :null => false
  
        t.timestamps
      end
    end
  
    def self.down
      drop_table :campaigns_games
    end
end
