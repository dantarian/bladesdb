class GameAttendance < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
    belongs_to :character
    
    has_many :food_choice
  
    before_validation :remove_character_if_not_playing
    
    validates_presence_of :user_id, :message => "^No user specified. This shouldn't happen."
    validates_uniqueness_of :user_id, :scope => :game_id, :message => "^There should only be one attendance per user per game."
    validates_presence_of :attend_state, :message => "^Status cannot be blank."
    validates_inclusion_of :attend_state, :in => ["undecided", "attending", "not_attending", "monstering", "playing", "gming"]
    validates_presence_of :confirm_state, :if => :playing?, :message => "^Confirmation state must be present if you are down to play."
    validates_inclusion_of :confirm_state, :in => ["requested", "priority", "confirmed", "rejected"], :if => :playing?
    validates_presence_of :character_id, :if => :playing?, :message => "^You must select a character if you are down to play."
    
    auto_strip_attributes :notes, :food_notes
    
    UNDECIDED = "undecided"
    NOT_ATTENDING = "not_attending"
    PLAYING = "playing"
    MONSTERING = "monstering"
    GMING = "gming"
    ATTENDING = "attending"
    
    REQUESTED = "requested"
    PRIORITY = "priority"
    CONFIRMED = "confirmed"
    REJECTED = "rejected"
    
    def undecided?
        self.attend_state == UNDECIDED
    end
    
    def not_attending?
        self.attend_state == NOT_ATTENDING
    end
    
    def monstering?
        self.attend_state == MONSTERING
    end
    
    def playing?
        self.attend_state == PLAYING
    end
    
    def gming?
        self.attend_state == GMING
    end
    
    def attending?
        self.attend_state != NOT_ATTENDING
    end
    
    def requested?
        self.confirm_state == REQUESTED
    end
    
    def prioritised?
        self.confirm_state == PRIORITY
    end
    
    def confirmed?
        self.confirm_state == CONFIRMED
    end
    
    def rejected?
        self.confirm_state == REJECTED
    end
    
    def remove_character
        self.confirm_state = nil
        self.character_id = nil      
    end
    
    def attend
        self.attend_state = ATTENDING
    end
    
    def become_undecided
        self.attend_state = UNDECIDED
    end
    
    def stop_attending
        self.attend_state = NOT_ATTENDING
    end
    
    def monster
        self.attend_state = MONSTERING
    end
    
    def gm
        self.attend_state = GMING
    end
    
    def request_to_play
        self.attend_state = PLAYING
        self.confirm_state = REQUESTED
    end

    def prioritise
        self.confirm_state = PRIORITY
    end    
    
    def confirm
        self.confirm_state = CONFIRMED
    end
    
    def reject
        self.confirm_state = REJECTED
    end
    
    def request
        self.confirm_state = REQUESTED
    end
    
    # If the character ID changes, change confirmation status back to "requested".
    def character_id=(new_character_id)
        if (new_character_id != nil) && (self.character_id.to_i != new_character_id.to_i)
            self.confirm_state = REQUESTED
        end
        write_attribute(:character_id, new_character_id)
    end
    
    def player_status
        case
        when confirmed? then "Confirmed:"
        when prioritised? then "Priority:"
        when rejected? then "Rejected:"
        end
    end
    
    def attendance_state
        if game.attendance_only and attending?
            "Attending"
        else
            case
            when playing? then "Play"
            when monstering? then "Monster"
            when not_attending? then "Not attending"
            else "-"
            end
        end
    end
    
    protected
    def remove_character_if_not_playing
        remove_character if !playing?
    end
end
