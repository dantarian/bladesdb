class MonsterPointSpend < ActiveRecord::Base
    belongs_to :character

    validates_presence_of :spent_on
    validates_each :spent_on, :on => :create do |record, attr, value|
        last_mp_spend = record.character.monster_point_spends.order("spent_on ASC").last
        record.errors.add attr, I18n.t("character.monster_points.not_before_last_spend", date: last_mp_spend.spent_on) unless (last_mp_spend.nil? or record.spent_on > last_mp_spend.spent_on)
    end
    validates_each :spent_on, :on => :create do |record, attr, value|
        game_dates = record.character.debriefs.to_a.map {|d| d.game.start_date }.sort
        last_but_one_game = game_dates.count > 1 ? game_dates[-2] : nil
        record.errors.add attr, I18n.t("character.monster_points.not_before_penultimate_game", date: last_but_one_game) unless (last_but_one_game.nil? or record.spent_on > last_but_one_game)
    end
    validates_each :spent_on, :on => :create do |record, attr, value|
        mpd = record.character.user.monster_point_declaration
        record.errors.add attr, I18n.t("character.monster_points.not_before_monster_point_declaration", date: mpd.declared_on) unless (mpd.nil? or record.spent_on > mpd.declared_on)
    end
    validates_each :spent_on, :on => :create do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.not_before_character_declaration", date: record.character.declared_on) unless record.spent_on > record.character.declared_on
    end
    validates_each :spent_on do |record, attr, value|
        record.errors.add attr, I18n.t("character.monster_points.not_in_future") unless value <= Date.today
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
        cp = self.character_points_before_spend
        total_cost = (cp...cp + self.character_points_gained).inject(0) do |cost, point|
            cost + (point.div 100) + 1
        end
        self.monster_points_spent = total_cost
        return total_cost <= monster_points_available
    end
    
    def monster_points_available
        recent = (self.spent_on > MonsterPointSpend.find(self.id).spent_on) unless new_record?
        self.character.user.monster_points_available_on(spent_on) + (new_record? ? 0 : (recent ? MonsterPointSpend.find(self.id).monster_points_spent : 0))
    end
    
    def character_points_before_spend
        recent = (self.spent_on > MonsterPointSpend.find(self.id).spent_on) unless new_record?
        self.character.points_on(spent_on) - (new_record? ? 0 : (recent ? MonsterPointSpend.find(self.id).character_points_gained : 0))      
    end
    
    def character_rank_before_spend
        self.character_points_before_spend/10.0
    end
end
