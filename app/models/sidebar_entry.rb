class SidebarEntry < ApplicationRecord
    default_scope { order(:order) }
  
    after_save :clear_category_cache
    after_destroy :clear_category_cache
  
    belongs_to :page
    belongs_to :sidebar_category, inverse_of: :sidebar_entries
    belongs_to :parent_entry, class_name: "SidebarEntry", inverse_of: :sidebar_entries
    has_many :sidebar_entries, inverse_of: :parent_entry, foreign_key: :parent_entry_id

    validates_presence_of :name
    validates_presence_of :page_id, :if => "url.nil?"
    validates_presence_of :url, :if => "page_id.nil?"
    validates_presence_of :order
    
    auto_strip_attributes :name, :url

    def get_target
        self.page || self.url
    end

    def clear_category_cache
        ActionController::Base.new.expire_fragment(parent_category)
    end
    
    def parent_category
        sidebar_category || parent_entry.parent_category
    end

    def self.fix_entry_order( parent_conditions )
        entries = SidebarEntry.where(parent_conditions)
        order = 0
        for entry in entries
            entry.order = ( order += 1 )
            entry.save
        end
    end

    def self.remove_orphans( params )
        if params[:category_id]
            entries = SidebarEntry.where("sidebar_category_id = ?", params[:category_id])
        else
            entries = SidebarEntry.where("parent_entry_id = ?", params[:parent_entry_id])
        end
        for entry in entries
            entry.destroy
            SidebarEntry.remove_orphans( :parent_entry_id => entry.id )
        end
    end
end

