class MonsterPointSpend < ActiveRecord::Base
    belongs_to :character
    validates_presence_of :spent_on
    validates_each :spent_on, :on => :create do |record, attr, value|
        last_mp_spend = record.character.monster_point_spends.last(:order => "spent_on ASC")
        last_date = [record.character.declared_on, (last_mp_spend ? last_mp_spend.spent_on : nil)].compact.max
        record.errors.add attr, "must be more recent than #{last_date}." unless record.spent_on > last_date
    end
    validates_each :spent_on, :on => :update do |record, attr, value|
        last_mp_spend = record.character.monster_point_spends.order(:spent_on).to_a[-2]
        last_date = [record.character.declared_on, (last_mp_spend ? last_mp_spend.spent_on : nil)].compact.max
        record.errors.add attr, "must be more recent than #{last_date}." unless record.spent_on > last_date
    end
    validates_each :spent_on do |record, attr, value|
        record.errors.add attr, "must not be in the future" unless value <= Date.today
    end
    validates_presence_of :character_points_gained, :if => :complete
    validates_numericality_of :character_points_gained, :greater_than => 0, :if => :complete
    validates_each :character_points_gained, :if => :complete do |record, attr, value|
        record.errors.add attr, "cost more monster points than you have to spend." unless record.has_enough_monster_points
    end
    
    attr_accessor :complete
    
    def has_enough_monster_points
        cp = self.character_points_before_spend
        total_cost = (cp...cp + self.character_points_gained).inject(0) do |cost, point|
            cost + (point.div 100) + 1
        end
        self.monster_points_spent = total_cost
        return total_cost <= self.monster_points_available_to_spend_on_character
    end
    
    def monster_points_available
        recent = (self.spent_on > MonsterPointSpend.find(self.id).spent_on) unless new_record?
        self.character.user.monster_points_available_on(spent_on) + (new_record? ? 0 : (recent ? MonsterPointSpend.find(self.id).monster_points_spent : 0))
    end
    
    def monster_points_available_to_spend_on_character
        self.character.monster_points_available_to_spend_on(spent_on, character_points_before_spend, self.id)
    end
    
    def character_points_before_spend
        recent = (self.spent_on > MonsterPointSpend.find(self.id).spent_on) unless new_record?
        self.character.points_on(spent_on) - (new_record? ? 0 : (recent ? MonsterPointSpend.find(self.id).character_points_gained : 0))      
    end
    
    def character_rank_before_spend
        self.character_points_before_spend/10.0
    end
end
