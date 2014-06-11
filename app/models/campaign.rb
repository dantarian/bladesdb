class Campaign < ActiveRecord::Base
    has_and_belongs_to_many :gamesmasters, :class_name => "User", :join_table => :campaign_games_masters
    has_and_belongs_to_many :games
    
    validates_presence_of :name
    validates_inclusion_of :current, :in => [true, false]
    validates_presence_of :start_date
    
    auto_strip_attributes :name
    
    def is_gm?(user)
        user && (gamesmasters.include? user)
    end
    
    def finished?
        end_date && end_date < Date.today
    end
end
