require 'securerandom'

class Game < ActiveRecord::Base
    include Rails.application.routes.url_helpers # Slightly nasty, but necessary to get the game URL for the boards post.
  
    has_and_belongs_to_many :gamesmasters, :class_name => "User", :join_table => :games_masters
    # has_many :food_options
    has_and_belongs_to_many :campaigns
    has_many :debriefs
    has_many :game_applications
    has_many :game_attendances
    has_many :characters, :through => :game_attendances
    has_many :users, :through => :game_attendances
    
    has_many :monstering_attendances, -> { where attend_state: GameAttendance::MONSTERING }, class_name: "GameAttendance"
    has_many :monsters, through: :monstering_attendances, source: :user
    has_many :player_attendances, -> { where attend_state: GameAttendance::PLAYING }, class_name: "GameAttendance"
    has_many :players, through: :player_attendances, source: :user
    has_many :non_attendances, -> { where attend_state: GameAttendance::NOT_ATTENDING }, class_name: "GameAttendance"
    has_many :non_attendees, through: :non_attendances, source: :user
    has_many :attendances, -> { where("attend_state != '#{GameAttendance::NOT_ATTENDING}'") }, class_name: "GameAttendance"
    has_many :attendees, through: :attendances, source: :user
    
    has_many :confirmed_player_attendances, -> { where(attend_state: GameAttendance::PLAYING, confirm_state: GameAttendance::CONFIRMED) }, class_name: "GameAttendance"
    has_many :confirmed_characters, through: :confirmed_player_attendances, source: :character
    has_many :prioritised_player_attendances, -> { where(attend_state: GameAttendance::PLAYING, confirm_state: GameAttendance::PRIORITY) }, class_name: "GameAttendance"
    has_many :prioritised_characters, through: :prioritised_player_attendances, source: :character
    has_many :requested_player_attendances, -> { where(attend_state: GameAttendance::PLAYING, confirm_state: GameAttendance::REQUESTED) }, class_name: "GameAttendance"
    has_many :requested_characters, through: :requested_player_attendances, source: :character
    has_many :rejected_player_attendances, -> { where(attend_state: GameAttendance::PLAYING, confirm_state: GameAttendance::REJECTED) }, class_name: "GameAttendance"
    has_many :rejected_characters, through: :rejected_player_attendances, source: :character
        
    validates_numericality_of :lower_rank, :only_integer => true, :greater_than_or_equal_to => 2, :allow_nil => true
    validates_numericality_of :upper_rank, :only_integer => true, :greater_than_or_equal_to => 2, :allow_nil => true
    validate :lower_rank_less_than_or_equal_to_upper_rank
    validates_numericality_of :player_points_base, :only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true
    validates_numericality_of :player_money_base, :only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true
    validates_numericality_of :monster_points_base, :only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true
    validates_presence_of :start_date
    validate :start_date_must_be_before_end_date
    validate :start_date_must_be_reasonable
    validate :meet_time_must_be_before_start_time
    # validates_inclusion_of :food, :in => [true, false]
    validates_inclusion_of :open, :in => [true, false]
    validates_inclusion_of :debrief_started, :in => [true, false]
    validates_presence_of :player_points_base, :if => :is_debrief_started?
    validates_presence_of :monster_points_base, :if => :is_debrief_started?
    validates_presence_of :player_money_base, :if => :is_debrief_started?
    
    before_validation :update_character_states
    after_update :remove_play_or_monster_attendances_for_gms
    
    auto_strip_attributes :title, :ic_brief, :ooc_brief, :ic_debrief, :ooc_debrief, :notes
    
    def self.future_games
        Game.where("(games.start_date >= ?)", Date.today).order(:start_date)
    end
    
    def game_title
        if self.title.nil? or self.title.blank?
            "Untitled"
        else
            self.title
        end
    end
    
    def date_range(twoline = false)
        if end_date.nil? or start_date == end_date
            "#{start_date}"
        else
            "#{start_date} - #{(twoline ? '<br />' : '')}#{end_date}".html_safe
        end
    end
    
    def rank_bracket
        upper = upper_rank/(upper_rank % 10 == 0 ? 10 : 10.0) unless upper_rank.nil?
        lower = lower_rank/(lower_rank % 10 == 0 ? 10 : 10.0) unless lower_rank.nil?
        case
            when (lower.nil? and upper.nil?) then "Unranked"
            when ((lower.nil? and upper == 2) or (lower == upper)) then "#{upper}"
            when lower.nil? then "2 - #{upper}"
            when upper.nil? then "#{lower}+"
            else "#{lower} - #{upper}"
        end
    end
    
    def formatted_meet_time
        if meet_time
            meet_time.strftime('%H:%M')
        else
            "11:00"
        end
    end
    
    def formatted_start_time
        if start_time
            start_time.strftime('%H:%M')
        else
            "12:00"
        end
    end
    
    def has_notes?
        !notes.nil? && !notes.empty?
    end
    
    def has_ic_brief?
        !ic_brief.nil? && !ic_brief.empty?
    end
    
    def has_ooc_brief?
        !ooc_brief.nil? && !ooc_brief.empty?
    end
    
    def has_ic_debrief?
        !ic_debrief.nil? && !ic_debrief.empty?
    end
    
    def has_ooc_debrief?
        !ooc_debrief.nil? && !ooc_debrief.empty?
    end
    
    def is_debrief_started?
        debrief_started
    end
    
    def is_debrief_finished?
        is_debrief_started? and !open
    end
    
    def setup_debrief
        (gamesmasters + monsters + rejected_characters.map{|character| character.user}).each { |monster| debriefs.build(:user_id => monster.id) }
        (confirmed_characters + prioritised_characters + requested_characters).each { |character| debriefs.build(:user_id => character.user_id, :character_id => character.id )}
    end
    
    def gm_debriefs
        debriefs.joins(game: :gamesmasters).where(character_id: nil).where("debriefs.user_id = games_masters.user_id")
    end
    
    def monster_debriefs
        debriefs.joins(:game).where(character_id: nil).where("user_id not in (select user_id from games_masters where game_id = #{self.id})")
    end
    
    def player_debriefs
        debriefs.where.not(character_id: nil)
    end
    
    def gm_points_available
        if player_points_base.nil? or monster_points_base.nil?
            0
        else
            player_points_base - monster_points_base - gm_debriefs.inject(0) { |sum, debrief| sum + (debrief.points_modifier || 0) }
        end
    end
    
    def can_view_applications?(user)
        user && (user.is_admin_or_committee? || campaigns.any?{|campaign| campaign.is_gm? user})
    end
    
    def is_editable_by?(user)
        user && (user.is_admin_or_committee? || (is_gm? user))
    end
    
    def is_user_profile?(user)
        user && (user.is_admin_or_committee_or_character_ref? || (is_gm? user) || user.is_first_aider?)
    end
    
    def is_gm?(user)
        gamesmasters.include? user
    end
    
    def attendance_state(user)
        if is_gm? user
            "GM"
        elsif is_debrief_started?
            case
            when player_debriefs.where(user_id: user.id).exists? then "Play"
            when monster_debriefs.where(user_id: user.id).exists? then "Monster"
            else "-"
            end
        elsif !open?
            "-"
        elsif !game_attendances.where(user_id: user.id).exists?
            "-"
        else
            game_attendances.where(user_id: user.id).first.attendance_state
        end
    end
    
    def application_for_user(user)
        game_applications.find_by(user_id: user.id)
    end
    
    def is_debriefable?
        (Time.local(start_date.year, start_date.month, start_date.day, start_time.hour, start_time.min) <= Time.now) and not self.attendance_only
    end
    
    def has_character?(character)
        if is_debrief_started?
            player_debriefs.map{|debrief| debrief.character}.member? character
        else
            characters.member? character
        end
    end

    def post_brief(current_user)
        make_boards_post(current_user, Board::BRIEFS, "Brief updated")
    end
        
    def post_debrief(current_user)
        make_boards_post(current_user, Board::DEBRIEFS, "Debrief published")
    end
    
    def is_editable?
        if attendance_only
            start_date >= Date.today
        else
            not is_debrief_finished?
        end
    end
    
    def self.next_free_sunday
        used_dates = Game.where("start_date >= :date OR end_date >= :date", date: Date.today).to_a.collect{ |game| ( game.end_date ? (game.start_date..game.end_date).to_a : game.start_date ) }.flatten
        next_sunday = Date.today.sunday
        next_sunday += 1.week if next_sunday == Date.today
        while used_dates.include? next_sunday
            next_sunday = next_sunday + 1.week
        end
        return next_sunday
    end
    
    def self.years
        Array(Game.first_year..Game.current_year)
    end
    
    def self.first_year
        first_game_date = Game.order(:start_date).first.start_date
        if first_game_date.month < 10
            first_game_date.year - 1
        else
            first_game_date.year
        end
    end
    
    def self.current_year
        if Date.today.month < 10
            Date.today.year - 1
        else
            Date.today.year
        end
    end
    
    def has_pending_applications?
        self.gamesmasters.empty? && self.game_applications.to_a.any?{|game_application| game_application.is_pending?}
    end
    
    protected
        def lower_rank_less_than_or_equal_to_upper_rank
            unless lower_rank.nil? or upper_rank.nil?
                errors.add(:upper_rank, "must be higher than lower rank") if upper_rank < lower_rank
            end
        end
        
        def start_date_must_be_before_end_date
            unless end_date.nil?
                errors.add(:end_date, "must not be before start date") if end_date < start_date
            end
        end
        
        def start_date_must_be_reasonable
            errors.add(:start_date, "must be less than two years in the future") if start_date > Date.today + 2.years
            errors.add(:start_date, "must be after 01/01/1997") if start_date < Date.new(1997,1,1)
        end
        
        def meet_time_must_be_before_start_time
            errors.add(:start_time, "must not be before meet time") if start_time < meet_time
        end

        def update_character_states
            # If we're closing a debrief, check through and see if anyone's become perm-dead as a result of dying with no DTs left.
            success = true
            if is_debrief_finished? and open_changed?
                player_debriefs.each do |debrief|
                    if !debrief.character.undeclared? and debrief.character.death_thresholds - (debrief.deaths || 0) < 0 and not debrief.character.dead?
                        success &&= debrief.character.update_attribute(:state, Character::PermDead)
                    end
                end
            end
            return success
        end
    
        def remove_play_or_monster_attendances_for_gms
            gamesmasters.each do |gm|
                attendance = game_attendances.where(user_id: gm.id).first
                attendance.destroy if attendance
            end
        end

        def make_boards_post(current_user, board, message_start)
            board_post = Board.find(board).messages.build
            board_post.message = "#{message_start} for the game \"#{h game_title}\":#{game_path(self)} on #{start_date}."
            board_post.user = current_user
            board_post.request_uuid = SecureRandom.uuid
            board_post.save!
        end
end
