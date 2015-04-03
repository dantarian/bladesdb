module MonsterPointSpendsHelper
    def monster_point_spend_earliest_allowed_date(character, monster_point_spend)
        if monster_point_spend && monster_point_spend.id
            last_mp_spend = character.monster_point_spends.where.not(id: monster_point_spend.id).order(:spent_on).last
        else
            last_mp_spend = character.monster_point_spends.order(:spent_on).last
        end
        last_cp_adjust = character.character_point_adjustments.order(:declared_on).last
        [character.declared_on + 1.day, (last_mp_spend ? last_mp_spend.spent_on + 1.day : nil), (last_cp_adjust ? last_cp_adjust.declared_on + 1.day : nil)].compact.max
    end
end
