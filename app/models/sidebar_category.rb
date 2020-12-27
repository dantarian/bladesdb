class SidebarCategory < ApplicationRecord
    include Rails.application.routes.url_helpers
    default_scope { order(:order) }
    
    has_many :sidebar_entries, -> { order :order }, autosave: true, inverse_of: :sidebar_category 

    validates_presence_of   :name
    validates_uniqueness_of :name
    
    auto_strip_attributes :name

    def entries(user)
        if self.name == "Message Boards" && @boards_added.nil?
            @boards_added = true
            highest_order = sidebar_entries.maximum(:order) || 0
            sidebar_entries + Board.open_boards.collect{|board| sidebar_entries.build( :url => board_path(board), 
                                                                                       :order => board.order + highest_order, 
                                                                                       :name => board.name_and_unread_messages(user) ) }
        else
            sidebar_entries
        end
    end
    
    def show?( user )
        case
        when user.nil? || !user.approved? then self.show_for_non_users
        when self.show_for_admin_users_only then user.is_admin_or_committee?
        else true
        end
    end

    def self.fix_category_order
        categories = SidebarCategory.all
        order = 0
        for category in categories
            category.order = ( order += 1 )
            category.save
        end
    end

    def self.next_order
        (SidebarCategory.reorder(order: :desc).limit(1).pluck(:order).first || 0) + 1
    end

    def next_entry_order
        (self.sidebar_entries.reorder(order: :desc).limit(1).pluck(:order).first || 0) + 1
    end

end
