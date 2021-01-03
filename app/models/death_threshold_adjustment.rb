class DeathThresholdAdjustment < ApplicationRecord
    belongs_to :character
    belongs_to :approved_by, :class_name => "User", optional: true

    validates_presence_of :character_id
    validates_presence_of :change
    validates_numericality_of :change, :only_integer => true, :less_than_or_equal_to => 10, :greater_than_or_equal_to => -10
    validates_presence_of :declared_on
    validates_presence_of :approved_by_id, :unless => :is_provisional?
    validates_presence_of :approved_at, :unless => :is_provisional?
    validates_presence_of :reason
    
    auto_strip_attributes :reason

    def self.pending_adjustments(except_user)
        DeathThresholdAdjustment.joins(:character).where(death_threshold_adjustments: {approved: nil}).where.not(characters: {user_id: except_user.id})
    end

    def is_approved?
        self.approved == true
    end
        
    def is_denied?
        self.approved == false
    end

    def is_provisional?
        self.approved == nil
    end
    
    def approve(current_user)
        @approval_recently_set = true
        self.approved = true
        self.approved_at = Time.now
        self.approved_by = current_user
    end
    
    def reject(current_user)
        @approval_recently_set = true
        self.approved = false
        self.approved_at = Time.now
        self.approved_by = current_user
    end
    
    def approval_recently_set?
        @approval_recently_set
    end
end
