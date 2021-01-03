class GuildMembership < ApplicationRecord
    belongs_to :character
    belongs_to :guild, optional: true
    belongs_to :guild_branch, optional: true
    belongs_to :approved_by, class_name: "User", optional: true

    #validates_presence_of :character_id
    validates_presence_of :declared_on
    validates_presence_of :approved_by_id, unless: :is_provisional_or_starting_guild?
    validates_presence_of :approved_at, unless: :is_provisional_or_starting_guild?
    validates_presence_of :guild_branch_id, unless: -> { guild_id.nil? || guild.guild_branches.empty? }
    validates_numericality_of :start_points, only_integer: true, greater_than_or_equal_to: 0, allow_nil: true
    validate :guild_start_points_less_than_or_equal_to_total_points
    validate :guild_or_branch_are_different_to_previous, on: :create

    def self.pending_guild_memberships(except_user)
        GuildMembership.joins(:character).where(guild_memberships: {approved: nil}).where.not(characters: {user_id: except_user.id})
    end

    def self.provisional_guild_memberships(except_user)
        GuildMembership.joins(character: :character_state).where(guild_memberships: {approved: true, provisional:true}).where.not(characters: {user_id: except_user.id}).where("guild_memberships.id = current_character_statuses.guild_membership")
    end

    # This refers to whether or not the membership change has been approved, not whether the character is a provisional guild member.
    # The "provisional" method provides the latter.
    def is_provisional?
        self.approved == nil
    end

    def rejected?
        self.approved == false
    end

    def start_rank
        calculated_start_points / 10.0
    end

    def calculated_start_points
        if start_points.nil?
            character.points_on(declared_on || Date.today)
        else
            start_points
        end
    end

    def full_guild_name
        case
        when guild.nil? then ""
        when guild_branch.nil? then guild.name
        else "#{guild.name} - #{guild_branch.name}"
        end
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

    protected
        def guild_start_points_less_than_or_equal_to_total_points
            errors.add(:start_points, I18n.t("character.guild_membership.failure.more_than_character_points")) unless start_points.nil? or character.starting_points.nil? or start_points <= character.starting_points
        end

        def guild_or_branch_are_different_to_previous
            unless character.guild_memberships.empty? or self == character.guild_memberships[0]
                errors.add(:base, I18n.t("character.guild_membership.failure.no_change")) if character.current_guild_membership.guild == guild and character.current_guild_membership.guild_branch == guild_branch and !character.current_guild_membership.provisional
            end
        end

        def is_provisional_or_starting_guild?
            is_provisional? or start_points == 0
        end
end
