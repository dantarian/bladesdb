class CharacterPointAdjustment < ActiveRecord::Base
    belongs_to :character
    belongs_to :approved_by, :class_name => "User"

    validates_presence_of :character_id
    validates_presence_of :points
    validates_presence_of :reason
    validates_numericality_of :points, :only_integer => true
    validates_presence_of :declared_on
    validates_presence_of :approved_by_id, :unless => :is_provisional?
    validates_presence_of :approved_at, :unless => :is_provisional?
    
    validates_each :declared_on, :on => :save do |record, attr, value|
        last_mp_spend = record.character.monster_point_spends.last(:order => "spent_on ASC")
        last_date = [record.character.declared_on, (last_mp_spend ? last_mp_spend.spent_on : nil)].compact.max
        record.errors.add attr, "must be more recent than #{last_date}." unless record.declared_on > last_date
    end
    
    auto_strip_attributes :reason

    def self.pending_adjustments(except_user)
        CharacterPointAdjustment.joins(:character).where(character_point_adjustments: {approved: nil}).where.not(characters: {user_id: except_user.id})
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
