class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :check_is_character_ref

    def approvals
        @character_requests = Character.pending_characters(current_user)
        @guild_change_requests = GuildMembership.pending_guild_memberships(current_user)
        @provisional_guild_memberships = GuildMembership.provisional_guild_memberships(current_user)
        @character_point_adjustments = CharacterPointAdjustment.pending_adjustments(current_user)
        @monster_point_declarations = MonsterPointDeclaration.pending_declarations(current_user)
        @monster_point_adjustments = MonsterPointAdjustment.pending_adjustments(current_user)
        @death_threshold_adjustments = DeathThresholdAdjustment.pending_adjustments(current_user)
        respond_to do |format|
            format.html
        end
    end
    
    private
        def check_is_character_ref
            unless current_user.is_character_ref?
                permission_denied
            end
        end
end