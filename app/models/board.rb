class Board < ActiveRecord::Base
    default_scope { order(:order) }

    has_many :messages, -> { order created_at: :desc }
    has_many :board_visits
    belongs_to :campaign
    
    validates_presence_of :name
    validates_inclusion_of :in_character, :in => [ true, false ]
    
    auto_strip_attributes :name, :blurb

    BRIEFS = 2
    DEBRIEFS = 3

    def name_and_unread_messages(user)
        new_messages = unread_messages(user)
                
        if new_messages > 0
            "#{self.name} (#{new_messages})"
        else 
            self.name
        end
    end
    
    def unread_messages(user)
        if user
            visit = board_visits.find_by(user_id: user.id)
            if visit
                new_message_count(visit.last_visit)
            else
                messages.size
            end
        else
            0
        end
    end
    
    def new_message_count(last_visit)
        messages.where("created_at > ?", last_visit).size
    end
    
    def closed?
        closed == true
    end
    
    def open?
        closed == false
    end
    
    def last_page
        (self.messages.size / 30.0).ceil
    end

    def self.open_boards
        Board.all.reject{|b| b.closed? }
    end

    def self.closed_boards
        Board.all.select{|b| b.closed? }
    end
end
