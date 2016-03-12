require 'digest/sha1'

class User < ActiveRecord::Base
    include AASM
    
    devise :database_authenticatable,
           :registerable,
           :recoverable,
           :rememberable,
           :confirmable,
           :validatable,
           :trackable,
           :encryptable,
           :encryptor => :restful_authentication_sha1

    before_save do |user|
        user.make_pending if (user.passive? and !user.encrypted_password.blank?)
    end

    has_many :permissions
    has_many :roles, :through => :permissions
    has_one :monster_point_declaration
    has_many :monster_point_adjustments
    has_many :monster_point_spends, :through => :characters
    has_and_belongs_to_many :mastered_games, :class_name => "Game", :join_table => :games_masters
    has_and_belongs_to_many :mastered_campaigns, :class_name => "Campaign", :join_table => :campaign_games_masters
    has_many :game_attendances
    has_many :debriefs
    has_many :game_applications
    has_many :characters
    has_many :messages
    has_many :board_visits
    has_many :attended_games, :through => :debriefs, :source => :game
    
    validates_presence_of   :username
    validates_length_of     :username,
                            :within => 3..40
    validates_uniqueness_of :username,
                            :case_sensitive => false
    validates_format_of     :username,    
                            :with => /\A\w[\w\.\-_@]+\z/, 
                            :message => "use only letters, numbers, and .-_@ please."

    validates_presence_of   :name
    validates_format_of     :name,     
                            :with => /\A[^[:cntrl:]\\<>\/&]*\z/,  
                            :message => "avoid non-printing characters and \\&gt;&lt;&amp;/ please."
    validates_uniqueness_of :name,
                            :case_sensitive => false
    validates_length_of     :name,     
                            :maximum => 100

    validates_presence_of   :email, :unless => :passive?
    validates_length_of     :email,    
                            :within => 6..100, #r@a.wk
                            :unless => :passive?
    validates_uniqueness_of :email,
                            :case_sensitive => false,
                            :unless => :passive?

    email_name_regex  = '[\w\.%\+\-]+'.freeze
    domain_head_regex = '(?:[A-Z0-9\-]+\.)+'.freeze
    domain_tld_regex  = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'.freeze
    email_regex       = /\A#{email_name_regex}@#{domain_head_regex}#{domain_tld_regex}\z/i

    validates_format_of     :email,    
                            :with => email_regex, 
                            :message => "should look like an email address.",
                            :unless => :passive?
                            
    auto_strip_attributes :username, :name, :email, :mobile_number, :contact_name, :contact_number, :medical_notes, :notes
    
    @updating = false

    aasm :column => 'state' do
        state :passive, :initial => true
        state :pending
        state :active,  :before_enter => :do_activate
        state :suspended
        state :deleted, :before_enter => :do_delete
        
        event :make_pending do
            transitions from: :passive, to: :pending
        end

        event :activate do
            transitions :from => :pending, :to => :active
        end
        
        event :suspend do
            transitions :from => [:passive, :pending, :active], :to => :suspended
        end
        
        event :delete do
            transitions :from => [:passive, :pending, :active, :suspended], :to => :deleted
        end
        
        event :unsuspend do
            transitions :from => :suspended, :to => :active,  :if => :confirmed?
            transitions :from => :suspended, :to => :pending, :if => :has_confirmation_token?
            transitions :from => :suspended, :to => :passive
        end
        
        event :undelete do
            transitions :from => :deleted, :to => :active,  :if => :confirmed?
            transitions :from => :deleted, :to => :pending, :if => :has_confirmation_token?
            transitions :from => :deleted, :to => :passive
        end
    end

    def after_confirmation
        self.activate!
    end
    
    def active_for_authentication?
        super && (self.active? || self.pending?)
    end

    def inactive_message
        if self.suspended?
            :suspended
        else
            super
        end
    end

    def email=(value)
        write_attribute :email, (value ? value.downcase : nil)
    end

    def email_required?
        !self.passive?
    end
    
    def confirmed_at=(value)
        @updating = true
        write_attribute :confirmed_at, value
    end
    
    def password_required?
        logger.debug "Password required: notupdating:#{!@pdating} and notpassive:#{!self.passive?} = #{!@updating and !self.passive?}"
        !@updating and !self.passive?
    end
    
    def updating=(value)
        @updating = value
    end

    def unconfirmed_email
      # ignore this field
    end

    def unconfirmed_email=(value)
      # ignore this field
    end

    def approve
        @approval_recently_set = true
        self.approved_at = Time.now.utc
    end

    def approval_recently_set?
        @approval_recently_set
    end

    def has_role?( rolename )
        self.roles.to_a.select{|role| role.rolename == rolename }.size > 0
    end
    
    def has_no_role?
      self.roles.empty?
    end
    
    def is_admin?
        self.has_role?("administrator")
    end
    
    def is_committee?
        self.has_role?("committee")
    end

    def is_character_ref?
        self.has_role?("characterref")
    end
    
    def is_webonly?
        self.has_role?("webonly") and self.approved? and self.active?
    end
    
    def is_normal?
        self.approved? && self.active? && !self.is_webonly?
    end
    
    def is_recent?
        !created_at.nil? && (created_at >= (Date.today - 3.months))
    end
    
    def is_first_aider?
        self.has_role?("firstaider")
    end
    
    def is_insurance?
        self.has_role?("insurance")
    end
    
    def is_experienced_gm?
      self.has_role?("experiencedgm")
    end
    
    def is_admin_or_committee?
        is_admin? || is_committee?
    end
    
    def is_admin_or_character_ref?
        is_admin? || is_character_ref?
    end
    
    def is_admin_or_committee_or_character_ref?
        is_admin? || is_committee? || is_character_ref?
    end
    
    def is_gm_for?( character_or_user )
        is_gm = false
        if character_or_user.is_a? Character
            unless character_or_user.user == self
                self.mastered_games.select{|game| !game.is_debrief_finished?}.each do |game|
                    if game.has_character? character_or_user
                        is_gm = true
                        break
                    end
                end
            end
        elsif character_or_user.is_a? User
            unless character_or_user == self
                self.mastered_games.select{|game| !game.is_debrief_finished?}.each do |game|
                    if game.users.include?(character_or_user)
                        is_gm = true
                        break
                    end
                end
            end
        else
            raise ArgumentError "Attempted to check the GM for an entity that is not a Character nor a User."
        end
        return is_gm
    end

    def has_outstanding_debriefs?
        outstanding_debriefs.size > 0
    end

    def outstanding_debriefs
        self.mastered_games.where("start_date <= ? and start_time <= ?", Date.today, Time.now).where(attendance_only: false, open: true)
    end

    def approved?
        !self.approved_at.blank?
    end
    
    def needs_medical_update? 
        self.is_normal? and (self.contact_name.blank? or self.contact_number.blank? or self.medical_notes.blank? or self.food_notes.blank? or self.emergency_last_updated.nil? or (self.emergency_last_updated < (Date.today - 3.months)))
    end
    
    def games_gmed
        self.mastered_games.where("start_date >= ? and start_date <= ?", current_year_start_date(Date.today), Date.today).where(attendance_only: false).to_a.inject(0) do |sum, game|
            sum += (game.end_date.nil? ? 1 : (game.end_date - game.start_date) + 1).to_i
        end
    end
    
    def games_played
        self.debriefs.joins(:game).where(games: {non_stats: false}).where.not(character_id: nil).where("games.start_date >= ?", current_year_start_date(Date.today)).select(:game_id).distinct.to_a.inject(0) do |sum, debrief|
            sum += (debrief.game.end_date.nil? ? 1 : (debrief.game.end_date - debrief.game.start_date) + 1).to_i
        end
    end
    
    def games_monstered
        self.debriefs.joins(:game).where("games.start_date >= ?", current_year_start_date(Date.today)).where(character_id: nil, games: {attendance_only: false}).to_a.inject(0) do |sum, debrief|
            sum += (debrief.game.end_date.nil? ? 1 : (debrief.game.end_date - debrief.game.start_date) + 1).to_i
        end
    end
    
    def games_gmed_ever
        self.mastered_games.where("start_date <= ?", Date.today).where(attendance_only: false).to_a.inject(0) do |sum, game|
            sum += (game.end_date.nil? ? 1 : (game.end_date - game.start_date) + 1).to_i
        end
    end
    
    def games_played_ever
        self.debriefs.joins(:game).where(games: {non_stats: false}).where.not(character_id: nil).select(:game_id).distinct.to_a.inject(0) do |sum, debrief|
            sum += (debrief.game.end_date.nil? ? 1 : (debrief.game.end_date - debrief.game.start_date) + 1).to_i
        end
    end
    
    def games_monstered_ever
        self.debriefs.joins(:game).where(character_id: nil, games: {attendance_only: false}).to_a.inject(0) do |sum, debrief|
            sum += (debrief.game.end_date.nil? ? 1 : (debrief.game.end_date - debrief.game.start_date) + 1).to_i
        end
    end
    
    def display_name( viewing_user )
        case
        when viewing_user.nil? then "Log in to view"
        when !viewing_user.approved? then h((self.name.scan(/\b\w/)*'').upcase)
        else h(self.name)
        end
    end

    def attendance_for( game )
        game_attendances.where(game_id: game.id).first
    end
    
    def visit( board )
        if board
            last_visit = board_visits.where(board_id: board.id).first || board_visits.build(board_id: board.id)
            last_visit.last_visit = Time.now
            last_visit.save
        end
    end
    
    def last_ten_comments
        self.debriefs.joins(:game).where(games: {debrief_started: true, open: false}).where.not("debriefs.remarks IS NULL OR debriefs.remarks = ''").order("games.start_date desc").limit(10)
    end
    
    def monster_points
        monster_points_available_on Date.today
    end
    
    def monster_points_available_on( date )
        total = 0
        monster_point_changes.each do |change|
            total += change.points if ((change.date <= date) and not(change.provisional or change.rejected or change.historical))
        end
        total - monster_points_to_keep_in_hand_after(date)
    end
    
    def monster_points_to_keep_in_hand_after( date )
        points_to_keep = 0
        running_total = 0
        monster_point_changes.each do |change|
            if (change.date > date) and not(change.provisional or change.rejected or change.historical)
                running_total -= change.points
                points_to_keep = [points_to_keep, running_total].max
            end
        end
        points_to_keep
    end

    def monster_point_changes
        if @changes.nil?
            @changes = []
            declaration_date = Date.new(1990, 1, 1)
            declaration_date = monster_point_declaration.declared_on unless (monster_point_declaration.nil? or monster_point_declaration.is_provisional?)
            unless monster_point_declaration.nil?
                change = MonsterPointChange.new
                change.source_object = monster_point_declaration
                change.date = monster_point_declaration.declared_on
                change.points = monster_point_declaration.points
                change.title = "Monster Points Declared"
                change.provisional = monster_point_declaration.approved.nil?
                change.rejected = (monster_point_declaration.approved == false)
                change.historical = false
                if monster_point_declaration.approved
                    change.approval = "Approved by #{monster_point_declaration.approved_by.name} at #{monster_point_declaration.approved_at}."
                elsif monster_point_declaration.approved == false
                    change.approval = "Rejected by #{monster_point_declaration.approved_by.name} at #{monster_point_declaration.approved_at}."
                end
                @changes.push(change)
            end
            monster_point_spends.to_a.each do |spend|
                change = MonsterPointChange.new
                change.source_object = spend
                change.date = spend.spent_on
                change.points = -spend.monster_points_spent
                change.title = "Bought #{spend.character_points_gained} CP for #{spend.character.name}"
                change.provisional = false
                change.rejected = false
                change.historical = (spend.spent_on < declaration_date)
                @changes.push(change)
            end
            monster_point_adjustments.to_a.each do |adjustment|
                change = MonsterPointChange.new
                change.source_object = adjustment
                change.date = adjustment.declared_on
                change.points = adjustment.points
                change.title = "Adjustment: #{adjustment.reason}"
                change.provisional = adjustment.approved.nil?
                change.rejected = (adjustment.approved == false)
                change.historical = (adjustment.declared_on < declaration_date)
                if adjustment.approved
                    change.approval = "Approved by #{adjustment.approved_by.name} at #{adjustment.approved_at}."
                elsif adjustment.approved == false
                    change.approval = "Rejected by #{adjustment.approved_by.name} at #{adjustment.approved_at}."
                end
                @changes.push(change)
            end
            debriefs.includes(:game).where(character_id: nil).to_a.each do |debrief|
                change = MonsterPointChange.new
                change.source_object = debrief
                change.date = debrief.game.start_date
                change.points = debrief.points
                change.title = debrief.game.title
                change.title = "Untitled Game" if change.title.nil? or change.title.blank?
                change.provisional = debrief.game.open
                change.rejected = false
                change.historical = debrief.game.start_date < declaration_date
                @changes.push(change)
            end
        end
        
        @changes.sort {|x,y| y.date <=> x.date } # Sort by reverse date.
    end

    class MonsterPointChange < Object
        attr_accessor :date, :points, :title, :provisional, :rejected, :historical, :approval, :source_object
    end
    
    def minimum_monster_points_remaining_after(date, monster_point_spend_to_ignore = nil)
        running_total = monster_points_available_on(date)
        monster_point_changes.select { |event|
            (event.date > date)
        }.inject(monster_points_available_on(date) + (monster_point_spend_to_ignore.nil? ? 0 : MonsterPointSpend.find(monster_point_spend_to_ignore).monster_points_spent)) do |min, event|
            if event.class == MonsterPointDeclaration
                running_total = event.points
                min = running_total
            else
                running_total += event.points
                min = [min, running_total].min
            end
       end 
    end
    
    def can_spend_monster_points?
        monster_points > 0 and monster_point_adjustments.where(approved: nil).empty? and
          (monster_point_declaration.nil? or !monster_point_declaration.is_provisional?)
    end
    
    def reason_for_being_unable_to_spend_monster_points
        case
        when monster_points <= 0
            "No monster points available"
        when !monster_point_adjustments.where(approved: nil).empty?
            "Outstanding character point adjustment requests"
        when (!monster_point_declaration.nil? and monster_point_declaration.is_provisional?)
            "Outstanding monster point declaration"
        end
    end
    
    protected

        def recently_activated?
            @activated
        end

        def do_activate
            @activated = true
            self.confirmed_at = Time.now.utc
            self.deleted_at = self.confirmation_token = nil
        end

        def do_delete
            self.deleted_at = Time.now.utc
        end

        def do_undelete
            self.deleted_at = nil
        end
        
    private
        def current_year_start_date(date)
            year = (date.month < 10) ? date.year - 1 : date.year
            year_start = DateTime.new(year, 10, 1)
        end

        def has_confirmation_token?
            !self.confirmation_token.nil?
        end
end
