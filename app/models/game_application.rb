class GameApplication < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
  
    validates_presence_of :game_id
    validates_presence_of :user_id
    validates_presence_of :details
    
    auto_strip_attributes :details

    @approved = false
    
    def approve
        @approved = true
    end
    
    def approved
        @approved
    end
    
end
