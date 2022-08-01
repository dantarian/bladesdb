class Board < ApplicationRecord
    default_scope { order(:order) }

    has_many :messages, -> { order created_at: :desc }
    has_many :board_visits
    belongs_to :campaign, optional: true
    
    validates_presence_of :name
    validates_inclusion_of :in_character, :in => [ true, false ]
    
    auto_strip_attributes :name, :blurb

    BRIEFS = 2
    DEBRIEFS = 3

    def self.total_unread_messages(user)
        Board.left_outer_joins(:board_visits)
             .joins(:messages)
             .where('messages.created_at > board_visits.last_visit OR board_visits.last_visit IS NULL')
             .where(closed: false)
             .where(board_visits: { user_id: user.id })
             .count || 0
    end

    def name_and_unread_messages(user)
        new_messages = unread_messages(user)
                
        if new_messages > 0
            "#{self.name} (#{new_messages})"
        else 
            self.name
        end
    end
    
    def unread_messages(user)
        return 0 unless user

        visit = board_visits.find_by(user_id: user.id)
        visit ? new_message_count(visit.last_visit) : messages.size
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
    
    def ic?
        in_character == true
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
