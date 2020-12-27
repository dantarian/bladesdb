class Debrief < ApplicationRecord
    belongs_to :game
    belongs_to :user
    belongs_to :character
  
    validates_presence_of :game_id
    validates_presence_of :user_id
    
    validates_numericality_of :base_points, :only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true
    validates_numericality_of :points_modifier, :only_integer => true, :allow_nil => true
    validates_numericality_of :money_modifier, :only_integer => true, :allow_nil => true
    validates_numericality_of :loot, :only_integer => true, :allow_nil => true
    validates_numericality_of :deaths, :only_integer => true, :allow_nil => true
    validate :max_one_gm_or_monster_debrief, :max_one_player_debrief, :base_points_less_than_or_equal_to_game_base, :danger_pay_non_negative
    
    after_destroy :delete_gm, :if => :is_gm_debrief?
    
    attr_accessor :player_debrief
    
    accepts_nested_attributes_for :character
    
    auto_strip_attributes :remarks
    
    def points
        if character.nil?
            (base_points.nil? ? game.monster_points_base : base_points) + (points_modifier || 0)
        else
            (base_points.nil? ? game.player_points_base : base_points) + (points_modifier || 0)
        end
    end
    
    def money
        unless character.nil? or game.player_money_base.nil?
            game.player_money_base + (money_modifier || 0)
        end
    end
    
    def is_provisional?
        game.open
    end
    
    def is_player_debrief?
        !character.nil? || @player_debrief
    end
    
    def is_gm_debrief?
        game.gamesmasters.exists? user.id
    end
    
    protected
        def max_one_gm_or_monster_debrief
            unless is_player_debrief?
                errors.add(:user_id, "already has a GM or monster debrief for this game") if 
                    (game.gm_debriefs + game.monster_debriefs).any? {|debrief| debrief.user == user and debrief.id != id }
            end
        end
        
        def max_one_player_debrief
            if is_player_debrief?
                errors.add(:character_id, "already has a player debrief for this game") if
                    (game.player_debriefs).any? {|debrief| debrief.character == character and debrief.id != id }
            end
        end
        
        def base_points_less_than_or_equal_to_game_base
            unless base_points.nil?
                if character.nil?
                    errors.add(:base_points, "must be less than or equal to monster base for the game") if base_points > game.monster_points_base
                else
                    errors.add(:base_points, "must be less than or equal to player base for the game") if base_points > game.player_points_base
                end
            end
        end
        
        def delete_gm
            game.gamesmasters.delete(user)
        end
        
        def danger_pay_non_negative
            if is_player_debrief?
                if !money.nil? && (money < 0)
                    errors.add(:money_modifier, "cannot reduce danger pay below zero florins")
                end
            end
        end
end
