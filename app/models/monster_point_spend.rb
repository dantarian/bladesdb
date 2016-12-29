class MonsterPointSpend < ActiveRecord::Base
    belongs_to :character

    validates_presence_of :spent_on
    validates_each :spent_on do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.not_before_last_spend", date: record.last_mp_spend.spent_on) if record.mp_spend_after?
    end
    validates_each :spent_on do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.not_before_most_recent_debrief", date: record.debrief_preventing_change.game.start_date) if record.closed_debriefs_after?
    end
    validates_each :spent_on do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.not_before_monster_point_declaration", date: record.character.user.monster_point_declaration.declared_on) if record.monster_point_declaration_after?
    end
    validates_each :spent_on do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.not_before_character_declaration", date: record.character.declared_on) unless record.spent_on > record.character.declared_on
    end
    validates_each :spent_on do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.not_in_future") unless value <= Date.today
    end
    validates_each :spent_on do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.not_before_character_point_adjustment", date: record.character_point_adjustment_preventing_change.declared_on) if record.character_point_adjustment_after?
    end
    
    validates_presence_of :character_points_gained, :if => :complete, :message => I18n.t("character.monster_points.at_least_one")
    validates_numericality_of :character_points_gained, :greater_than => 0, :if => :complete, :message => I18n.t("character.monster_points.at_least_one")
    
    validates_each :monster_points_spent, :if => :complete do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.not_enough_mp", points: record.monster_points_available) if record.spending_too_many_monster_points?
    end
    validates_each :character_points_gained, :if => :complete do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.too_many_cp", points: record.max_character_points) if record.buying_too_many_character_points?
    end
    
    attr_accessor :complete
    
    def self.fix_after(date)
        MonsterPointSpend.where(spent_on: date..Date.today).each do |spend|
            spend.fix_points
        end
    end
    
    def spending_too_many_monster_points?
        !has_enough_monster_points
    end

    def max_character_points
        cp = self.character_points_before_spend
        [100 - cp, 30 - character.points_bought_since_last_game(spent_on)].max
    end
    
    def buying_too_many_character_points?
        character_points_gained > max_character_points
    end
    
    def has_enough_monster_points
        self.monster_points_spent = calculated_cost
        return monster_points_spent <= monster_points_available
    end
    
    def monster_points_available
        self.character.user.monster_points_available_on(spent_on)
    end
    
    def character_points_before_spend
        points = self.character.points_on(spent_on - 1.day)
        self.character.character_point_adjustments.where(approved: nil).where("declared_on <= ?", spent_on).each do |cpa|
            points = [points, points + cpa.points].max
        end
        points
    end
    
    def character_rank_before_spend
        self.character_points_before_spend/10.0
    end
    
    def can_delete?
        !mp_spend_after? and !closed_debriefs_after?
    end
    
    def mp_spend_after?
        self.character.monster_point_spends.where("spent_on > ?", spent_on).exists?
    end
    
    def last_mp_spend
        self.character.monster_point_spends.order(:spent_on).last
    end
    
    def last_spend?
        self.id == last_mp_spend.id
    end
    
    def closed_debriefs_after?
        !debrief_preventing_change.nil?
    end
    
    def debrief_preventing_change
        self.character.debriefs.joins(:game).where(games: {debrief_started: true, open: false}).where("games.start_date >= ?", spent_on).order('games.start_date desc').first
    end
    
    def monster_point_declaration_after?
        declaration = self.character.user.monster_point_declaration
        !(declaration.nil?) and !(declaration.is_rejected?) and declaration.declared_on > self.spent_on
    end
    
    def monster_point_adjustment_preventing_change
        self.character.user.monster_point_adjustments.where("declared_on > ?", spent_on).where('approved = ? or approved is null', true).order(declared_on: :desc).first
    end
    
    def monster_point_adjustment_after?
        !(monster_point_adjustment_preventing_change.nil?)
    end

    def character_point_adjustment_preventing_change
        self.character.character_point_adjustments.where("declared_on > ?", spent_on).where('approved = ? or approved is null', true).order(declared_on: :desc).first
    end
    
    def character_point_adjustment_after?
        !(character_point_adjustment_preventing_change.nil?)
    end
    
    def calculated_cost
        cp = self.character_points_before_spend
        return (cp...cp + self.character_points_gained).inject(0) do |cost, point|
            cost + (point.div 100) + 1
        end
    end
    
    def fix_points
        original_cost = monster_points_spent
        new_cost = calculated_cost
        if monster_points_spent != new_cost
            update!(monster_points_spent: new_cost)
            if new_cost > original_cost
                UserMailer.mp_spend_cost_increase(self, original_cost).deliver
            else
                UserMailer.mp_spend_cost_decrease(self, original_cost).deliver
            end
        end
    end
end

