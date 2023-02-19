class AddAllTheIndexes < ActiveRecord::Migration[4.2]
    def self.up
        add_index :character_point_adjustments, :declared_on, :unique => false
        add_index :character_point_adjustments, :character_id, :unique => false
        add_index :characters, :user_id, :unique => false
        add_index :credits, :transaction_id, :unique => true
        add_index :credits, :character_id, :unique => false
        add_index :death_threshold_adjustments, :declared_on, :unique => false
        add_index :death_threshold_adjustments, :character_id, :unique => false
        add_index :debits, :transaction_id, :unique => true
        add_index :debits, :character_id, :unique => false
        add_index :debriefs, :game_id, :unique => false
        add_index :debriefs, :user_id, :unique => false
        add_index :debriefs, :character_id, :unique => false
        add_index :game_attendances, :game_id, :unique => false
        add_index :games_masters, :game_id, :unique => false
        add_index :games_masters, :user_id, :unique => false
        add_index :guild_memberships, :declared_on, :unique => false
        add_index :guild_memberships, :character_id, :unique => false
        add_index :monster_point_adjustments, :declared_on, :unique => false
        add_index :monster_point_adjustments, :user_id, :unique => false
        add_index :monster_point_declarations, :declared_on, :unique => false
        add_index :monster_point_declarations, :user_id, :unique => true
        add_index :monster_point_spends, :spent_on, :unique => false
        add_index :monster_point_spends, :character_id, :unique => false
        add_index :transactions, :transaction_date, :unique => false
        add_index :games, :start_date, :unique => false
        add_index :messages, :created_at, :unique => false
    end

    def self.down
        remove_index :character_point_adjustments, :column => :declared_on
        remove_index :character_point_adjustments, :column => :character_id
        remove_index :characters, :column => :user_id
        remove_index :credits, :column => :transaction_id
        remove_index :credits, :column => :character_id
        remove_index :death_threshold_adjustments, :column => :declared_on
        remove_index :death_threshold_adjustments, :column => :character_id
        remove_index :debits, :column => :transaction_id
        remove_index :debits, :column => :character_id
        remove_index :debriefs, :column => :game_id
        remove_index :debriefs, :column => :user_id
        remove_index :debriefs, :column => :character_id
        remove_index :game_attendances, :column => :game_id
        remove_index :games_masters, :column => :game_id
        remove_index :games_masters, :column => :user_id
        remove_index :guild_memberships, :column => :declared_on
        remove_index :guild_memberships, :column => :character_id
        remove_index :monster_point_adjustments, :column => :declared_on
        remove_index :monster_point_adjustments, :column => :user_id
        remove_index :monster_point_declarations, :column => :declared_on
        remove_index :monster_point_declarations, :column => :user_id
        remove_index :monster_point_spends, :column => :spent_on
        remove_index :monster_point_spends, :column => :character_id
        remove_index :transactions, :column => :transaction_date
        remove_index :games, :column => :start_date
        remove_index :messages, :column => :created_at
    end
end
