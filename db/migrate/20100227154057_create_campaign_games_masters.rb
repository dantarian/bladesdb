class CreateCampaignGamesMasters < ActiveRecord::Migration[4.2]
    def self.up
      create_table :campaign_games_masters, :id => false do |t|
        t.references :campaign, :null => false
        t.references :user, :null => false
  
        t.timestamps
      end
    end
  
    def self.down
      drop_table :campaign_games_masters
    end
end
