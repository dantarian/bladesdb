class CreateSidebarEntries < ActiveRecord::Migration[4.2]
    def self.up
        create_table :sidebar_entries do |t|
            t.references :page,             :null => true
            t.references :sidebar_category, :null => true
            t.references :parent_entry,     :null => true
            t.string     :url,              :null => true
            t.integer    :order,            :null => false
            t.string     :name,             :null => false, :limit => 50
            t.boolean    :editable,         :null => false, :default => true
            t.timestamps
        end
    end

    def self.down
        drop_table :sidebar_entries
    end
end
