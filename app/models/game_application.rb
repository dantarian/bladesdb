class GameApplication < ApplicationRecord
    belongs_to :game
    belongs_to :user
  
    validates_presence_of :game_id
    validates_presence_of :user_id
    validates_presence_of :details
    
    auto_strip_attributes :details, :comment

    
    def reset
        self.approved = nil
        self.comment = nil
    end
    
    def approve
        self.approved = true
    end
    
    def reject
        self.approved = false
    end
    
    def is_pending?
        self.approved == nil
    end
    
    def is_approved?
        self.approved == true
    end
    
    def is_rejected?
        self.approved == false
    end
    
end
