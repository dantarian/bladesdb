module CharacterPointAdjustmentsHelper
    def character_point_adjustment_earliest_allowed_date(character)
        last_mp_spend = character.monster_point_spends.order(spent_on: :desc).first
        [character.declared_on + 1.day, (last_mp_spend ? last_mp_spend.spent_on + 1.day : nil)].compact.max
    end
end
