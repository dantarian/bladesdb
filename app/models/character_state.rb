class CharacterState < ApplicationRecord
    self.primary_key = :id
    self.table_name = "current_character_statuses"
    belongs_to :character
    belongs_to :current_guild_membership, class_name: "GuildMembership", foreign_key: "guild_membership"
    
    def readonly?
      true
    end
end
