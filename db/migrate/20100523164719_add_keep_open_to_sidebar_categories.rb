class AddKeepOpenToSidebarCategories < ActiveRecord::Migration[4.2]
  def self.up
    add_column :sidebar_categories, :always_open, :boolean, :default => false
  end

  def self.down
    remove_column :sidebar_categories, :always_open
  end
end
