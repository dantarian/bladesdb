class MonsterPointDeclaration < ActiveRecord::Base
    belongs_to :user
    belongs_to :approved_by, :class_name => "User"

    validates_presence_of :user_id
    validates_presence_of :points
    validates_numericality_of :points, :only_integer => true, :greater_than_or_equal_to => 0
    validates_presence_of :declared_on
    validates_presence_of :approved_by_id, :unless => :is_provisional?
    validates_presence_of :approved_at, :unless => :is_provisional?

    def self.pending_declarations(except_user)
        MonsterPointDeclaration.where(approved: nil).where.not(user_id: except_user.id)
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
