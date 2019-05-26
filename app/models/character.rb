class Character < ActiveRecord::Base
    belongs_to :user
    belongs_to :race
    belongs_to :approved_by, :class_name => "User"
    has_many :guild_memberships, -> { order declared_on: :asc, id: :asc }
    accepts_nested_attributes_for :guild_memberships
    has_many :game_attendances
    has_many :debriefs, -> { includes( :game, character: [ :guild_memberships ] ) }
    has_many :monster_point_spends
    has_many :character_point_adjustments
    has_many :death_threshold_adjustments
    has_many :debits
    has_many :credits
    has_one :character_state, -> { includes( current_guild_membership: [ { guild: :titles }, :guild_branch ] ) }

    # Constants
    Active = "active"
    Retired = "retired"
    PermDead = "permdead"
    Undeclared = "undeclared" # Applies to characters imported from LARPdb.
    Recycled = "recycled"

    validates_presence_of :user_id
    validates_presence_of :name
    validates_presence_of :starting_points, :unless => :undeclared?
    validates_numericality_of :starting_points, :unless => :undeclared?, :greater_than_or_equal_to => 20
    validates_presence_of :starting_florins, :unless => :undeclared?
    validates_numericality_of :starting_florins, :unless => :undeclared?, :greater_than_or_equal_to => 0
    validates_inclusion_of :date_of_birth_public, :in => [true, false], :unless => "date_of_birth.nil?"
    validates_presence_of :state
    validates_inclusion_of :state, :in => [Active, Retired, PermDead, Undeclared, Recycled]
    validates_presence_of :starting_death_thresholds, :unless => :undeclared?
    validates_numericality_of :starting_death_thresholds, :only_integer => true, :unless => :undeclared?
    validates_each :starting_death_thresholds, :unless => "race_id.nil?" do |record, attr, value|
        max_dt = record.race.death_thresholds
        record.errors.add attr, I18n.t("character.validation.dts_greater_than_race") unless (record.starting_death_thresholds || 0) <= record.race.death_thresholds
        record.errors.add attr, I18n.t("character.validation.dts_less_than_zero") unless (record.starting_death_thresholds || 0) >= 0
    end

    before_update :add_monster_point_adjustment_for_recycling

    default_scope { includes(:character_state, :user, :race) }

    auto_strip_attributes :name, :biography, :address, :notes, :gm_notes

    # Somewhere to store the points total after the first time it's calculated.
    @total_points = nil
    @death_thresholds = nil
    @current_guild_membership = nil

    def self.pending_characters(except_user)
        Character.where(approved: nil).where.not(user_id: except_user.id).where.not(state: Character::Undeclared)
    end

    def played_games
        self.debriefs.to_a.map{|debrief| debrief.game}
    end

    def undeclared?
        state == Undeclared
    end

    def recycled?
        state == Recycled
    end

    def can_recycle?
        (debriefs.joins(:game).where(games: { non_stats: false }).count <= 3) and not recycled?
    end

    def is_provisional?
        approved.nil?
    end

    def approved?
        self.approved == true
    end

    def retire
        if active?
            state = Retired
        end
    end

    def reactivate
        if retired?
            state = Active
        end
    end

    def perm_kill
        state = PermDead
    end

    def resurrect_from_perm_death
        if dead?
            state = Active
        end
    end

    def approve(current_user)
        @approval_recently_set = true
        self.approved = true
        self.approved_on = Date.today
        self.approved_by = current_user
    end

    def reject(current_user)
        @approval_recently_set = true
        self.approved = false
        self.approved_on = Date.today
        self.approved_by = current_user
    end

    def approval_recently_set?
        @approval_recently_set
    end

    def name_and_title(unescaped = false)
        unless title.blank?
            "#{title} #{name}"
        else
            unless (guild.nil? || no_title == true)
                guild_title = guild.calculate_title(points - (current_guild_membership.calculated_start_points || 0))
                if guild_title.include? "BRANCH"
                   branch_title = current_guild_membership.guild_branch.nil? ? " " : current_guild_membership.guild_branch.branch_title
                   guild_title = guild_title.sub(/BRANCH/, branch_title.to_s)
                end
                "#{guild_title} #{name}"
            else
                name
            end
        end
    end

    def title_name_and_rank(unescaped = false)
        "#{name_and_title(unescaped)} (#{rank})"
    end

    def points_on(date)
        cumulative_points = starting_points
        debriefs.joins(:game).where(games: {debrief_started: true, open: false}).where("games.start_date >= ? AND games.start_date <= ?", declared_on, date).each do |debrief|
            cumulative_points += debrief.points
        end
        cumulative_points += monster_point_spends.where("spent_on >= ? AND spent_on <= ?", declared_on, date).sum(:character_points_gained)
        cumulative_points += character_point_adjustments.where(approved: true).where("declared_on >= ? AND declared_on <= ?", declared_on, date).sum(:points)
        return cumulative_points
    end

    def rank_on(date)
        points_on(date)/10.0
    end

    def points
        @total_points ||= character_state.points.to_i
    end

    def rank
        points/10.0
    end

    def death_thresholds
        @death_thresholds ||= character_state.death_thresholds.to_i
    end

    def state_readable
        case
        when active? then "Active"
        when retired? then "Retired"
        when dead? then "Dead"
        when undeclared? then "Undeclared"
        when recycled? then "Recycled"
        else state
        end
    end

    def currently_active?
        (state == Active) && (self.user.is_normal?) && self.approved?
    end

    def active?
        state == Active
    end

    def retired?
        state == Retired
    end

    def dead?
        state == PermDead
    end

    def undeclared?
        state == Undeclared
    end

    def guild_membership_on(date)
        approved_memberships = guild_memberships.where(approved: true).where("declared_on <= ?", date).includes(:guild)
        all_memberships = guild_memberships.where("declared_on <= ?", date).includes(:guild)
        approved_memberships.last || all_memberships.last || guild_memberships.build(start_points: 0, approved: true)
    end

    def current_guild_membership
        @current_guild_membership ||= guild_memberships.find(character_state.guild_membership.to_i) || guild_memberships.build(start_points: 0, approved: true)
    end

    def outstanding_guild_membership_request
        last_request = guild_memberships.last
        if last_request.nil? or last_request.approved
            nil
        else
            last_request
        end
    end

    def guild
        guild_memberships.empty? ? nil : current_guild_membership.guild
    end

    def full_guild_name
        guild.nil? ? "" : current_guild_membership.full_guild_name
    end

    def money
        money_on(Date.today)
    end

    def money_on(date)
        money_events.select { |event| !event.provisional and !event.rejected and !event.historical and event.date <= date }.inject(0) { |sum, event| sum + event.taxed_money + (event.loot || 0) }
    end

    def formatted_date_of_birth
        unless date_of_birth.nil?
            if (date_of_birth.year >= 1900)
                "#{date_of_birth.strftime('%d %b')} #{date_of_birth.year - 1900} AE"
            else
                "#{date_of_birth.strftime('%d %b')} #{1900 - date_of_birth.year} BE"
            end
        end
    end

    def played_before(date)
        if starting_points > 20
            true
        else
            not debriefs.joins(:game).where("games.start_date < ?", date).empty?
        end
    end

    def games_played_since(date)
        debriefs.joins(:game).where("games.start_date > ?", date).count
    end

    def points_earned_since(date)
        points - points_on(date)
    end

    def can_spend_monster_points?
        character_point_adjustments.where(approved: nil).empty? and debriefs.joins(:game).where(games: {open: true}).empty? and approved == true and active?
    end

    def reason_for_being_unable_to_spend_monster_points
        case
        when !character_point_adjustments.where(approved: nil).empty?
            "Outstanding character point adjustment requests"
        when !debriefs.joins(:game).where(games: {open: true}).empty?
            "Outstanding debriefs"
        when approved != true
            "Character not approved"
        when !active?
            "Character not active"
        else
            user.reason_for_being_unable_to_spend_monster_points
        end
    end

    def points_bought_since_last_game(date)
        last_game_date = declared_on
        unless debriefs.empty?
            last_game_date = debriefs.joins(:game).where(games: {non_stats: false}).where("games.start_date <= ?", date).maximum("games.start_date") || declared_on
        end
        monster_point_spends.where("spent_on > ? and spent_on < ?", last_game_date, date).sum(:character_points_gained)
    end

    def monster_points_available_to_spend_on(date, precalculated_character_points = nil, monster_point_spend_to_ignore = nil)
        precalculated_character_points = points_on(date) if precalculated_character_points.nil?
        if precalculated_character_points >= 100
            last_game_date = declared_on
            unless debriefs.empty?
                last_game_date = debriefs.joins(:game).where(games: {non_stats: false}).where("games.start_date <= ?", date).maximum("games.start_date")
            end
            monster_points_spent_since_last_game = monster_point_spends.where("spent_on > ? and spent_on < ?", last_game_date, date).where.not(id: monster_point_spend_to_ignore).sum(:monster_points_spent)
            user.minimum_monster_points_remaining_after(date, monster_point_spend_to_ignore)
        else
            user.minimum_monster_points_remaining_after(date, monster_point_spend_to_ignore)
        end
    end

    def points_accumulated_in_current_guild
        guild_changed = false
        guild_memberships.reverse.inject do |points, membership|
            if membership.guild = guild and not membership.guild.provisional
                if guild_changed
                    points
                else
                    points + membership.calculated_start_points
                end
            else
                guild_changed = true
                points
            end
        end
    end

    def last_monster_point_spend
        monster_point_spends.order(:spent_on).last
    end

    def events
        # Pull in debriefs, monster point spends, character declaration and requested/approved character point and death threshold adjustments and sort them by date order.
        if @events.nil?
            @events = Array.new
            debriefs.each do |debrief|
                if debrief.game.is_debrief_finished?
                    event = CharacterEvent.new
                    event.date = debrief.game.start_date
                    event.points = (debrief.base_points || debrief.game.player_points_base) + (debrief.points_modifier || 0)
                    event.title = debrief.game.game_title
                    event.comment = debrief.remarks
                    event.deaths = debrief.deaths
                    event.provisional = false
                    event.rejected = false
                    event.historical = (event.date < self.declared_on)
                    event.source_object = debrief
                    @events.push(event)
                end
            end
            monster_point_spends.each do |spend|
                event = CharacterEvent.new
                event.date = spend.spent_on
                event.points = spend.character_points_gained
                event.title = "Monster Points Spent"
                event.comment = "#{spend.monster_points_spent} monster points spent for #{spend.character_points_gained} character points."
                event.provisional = false
                event.rejected = false
                event.deaths = 0
                event.historical = false
                @events.push(event)
            end
            character_point_adjustments.each do |adjustment|
                event = CharacterEvent.new
                event.date = adjustment.declared_on
                event.points = adjustment.points
                event.title = "Character Points Adjusted"
                event.deaths = 0
                if adjustment.is_provisional?
                    event.provisional = true
                    event.rejected = false
                    event.comment = "Reason: #{adjustment.reason}\nNot yet approved."
                elsif adjustment.is_denied?
                    event.provisional = false
                    event.rejected = true
                    if adjustment.approved_by.nil?
                        event.comment = "Reason: #{adjustment.reason}"
                    else
                        event.comment = "Reason: #{adjustment.reason}\nRejected by #{adjustment.approved_by.name} at #{adjustment.approved_at}."
                    end
                else
                    event.provisional = false
                    event.rejected = false
                    if adjustment.approved_by.nil?
                        event.comment = "Reason: #{adjustment.reason}"
                    else
                        event.comment = "Reason: #{adjustment.reason}\nApproved by #{adjustment.approved_by.name} at #{adjustment.approved_at}."
                    end
                end
                event.source_object = adjustment
                event.historical = false
                @events.push(event)
            end
            death_threshold_adjustments.each do |adjustment|
                event = CharacterEvent.new
                event.date = adjustment.declared_on
                event.points = 0
                event.title = "Death Thresholds Adjusted"
                event.deaths = -adjustment.change
                if adjustment.is_provisional?
                    event.provisional = true
                    event.rejected = false
                    event.comment = "Reason: #{adjustment.reason}\nNot yet approved."
                elsif adjustment.is_denied?
                    event.provisional = false
                    event.rejected = true
                    if adjustment.approved_by.nil?
                        event.comment = "Reason: #{adjustment.reason}"
                    else
                        event.comment = "Reason: #{adjustment.reason}\nRejected by #{adjustment.approved_by.name} at #{adjustment.approved_at}."
                    end
                else
                    event.provisional = false
                    event.rejected = false
                    if adjustment.approved_by.nil?
                        event.comment = "Reason: #{adjustment.reason}"
                    else
                        event.comment = "Reason: #{adjustment.reason}\nApproved by #{adjustment.approved_by.name} at #{adjustment.approved_at}."
                    end
                end
                event.source_object = adjustment
                event.historical = false
                @events.push(event)
            end
            unless undeclared?
                event = CharacterEvent.new
                event.date = declared_on
                event.points = starting_points
                event.title = "Character Declared"
                if approved
                    event.provisional = false
                    event.rejected = false
                    if approved_by.nil?
                        event.comment = "Declared as a new character on #{approved_on}."
                    else
                        event.comment = "Approved by #{approved_by.name} on #{approved_on}."
                    end
                elsif not approved.nil?
                    event.provisional = false
                    event.rejected = true
                    event.comment = "Rejected by #{approved_by.name} on #{approved_on}."
                else
                    event.provisional = true
                    event.rejected = false
                    event.comment = "Not yet approved."
                end
                @events.push(event)
            end
        end

        @events.sort {|x,y| y.date <=> x.date } # Sort by reverse date.
    end

    def money_events
        if @money_events.nil?
            @money_events = Array.new
            debriefs.each do |debrief|
                if debrief.game.is_debrief_finished?
                    event = MoneyEvent.new
                    event.date = debrief.game.start_date
                    event.money = debrief.money
                    event.loot = debrief.loot
                    event.other_party = "Danger Pay + In-Game Transactions"
                    event.comment = debrief.game.game_title
                    event.provisional = false
                    event.rejected = false
                    event.historical = (event.date < self.declared_on)
                    event.tax_rate = 0
                    event.tax_rate = guild_membership_on(event.date).guild.tax_rate unless guild_membership_on(event.date).guild.nil?
                    if event.tax_rate > 0
                        event.comment += "\nGuild tax paid to #{guild_membership_on(event.date).guild.name}."
                    end
                    event.source_object = debrief
                    @money_events.push(event)
                end
            end
            credits.each do |credit|
                event = MoneyEvent.new
                event.date = credit.transaction.transaction_date
                event.money = credit.transaction.value
                event.other_party = credit.transaction.debit.subject_name
                event.comment = credit.transaction.description
                event.provisional = false
                event.rejected = false
                event.historical = (event.date < self.declared_on)
                event.tax_rate = 0
                event.source_object = credit
                @money_events.push(event)
            end
            debits.each do |debit|
                event = MoneyEvent.new
                event.date = debit.transaction.transaction_date
                event.money = -debit.transaction.value
                event.other_party = debit.transaction.credit.subject_name
                event.comment = debit.transaction.description
                event.provisional = false
                event.rejected = false
                event.historical = (event.date < self.declared_on)
                event.tax_rate = 0
                event.source_object = debit
                @money_events.push(event)
            end
            unless undeclared?
                event = MoneyEvent.new
                event.date = declared_on
                event.money = starting_florins
                event.other_party = "Character Declared"
                event.historical = false
                event.tax_rate = 0
                if approved
                    event.provisional = false
                    event.rejected = false
                    if approved_by.nil?
                        event.comment = "Declared as a new character on #{approved_on}."
                    else
                        event.comment = "Approved by #{approved_by.name} on #{approved_on}."
                    end
                elsif not approved.nil?
                    event.provisional = false
                    event.rejected = true
                    event.comment = "Rejected by #{approved_by.name} on #{approved_on}."
                else
                    event.provisional = true
                    event.rejected = false
                    event.comment = "Not yet approved."
                end
                @money_events.push(event)
            end

        end

        @money_events.sort { |x,y| y.date <=> x.date } # Sort by reverse date.
    end

    class Event < Object
        attr_accessor :date, :comment, :provisional, :rejected, :source_object, :historical
    end

    class CharacterEvent < Event
        attr_accessor :title, :points, :deaths
    end

    class MoneyEvent < Event
        attr_accessor :money, :other_party, :tax_rate, :loot

        def taxed_money
            money - tax
        end

        def tax
            if money > 0
                (money * (tax_rate || 0)).round
            else
                0
            end
        end
    end

    protected
        def add_monster_point_adjustment_for_recycling
            if recycled? and state_was == Active
                mp_spends = monster_point_spends.to_a
                mp_regained = mp_spends.map(&:monster_points_spent).sum
                earned_points = points - 20 - mp_spends.map(&:character_points_gained).sum
                adjustment = user.monster_point_adjustments.new
                adjustment.points = mp_regained + earned_points
                adjustment.reason = "Character recycled: #{name}"
                adjustment.declared_on = Date.today
                adjustment.save!
            end
        end
end
