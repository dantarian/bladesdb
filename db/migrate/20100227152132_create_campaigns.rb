class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.string :name, :null => false
      t.boolean :current, :null => false, :default => false
      t.date :start_date, :null => false
      t.date :end_date, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns
  end
end
