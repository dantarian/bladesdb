class CreateSidebarCategories < ActiveRecord::Migration
    def self.up
        create_table :sidebar_categories do |t|
            t.string :name
            t.integer :order
            t.boolean :show_for_non_users
            t.boolean :show_for_admin_users_only
            t.boolean :editable, :default => true

            t.timestamps
        end
    end

    def self.down
        drop_table :sidebar_categories
    end
end
