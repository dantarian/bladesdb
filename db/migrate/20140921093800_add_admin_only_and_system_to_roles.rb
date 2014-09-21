class AddAdminOnlyAndSystemToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :admin_only, :boolean, null: false, default: false
    add_column :roles, :system, :boolean, null: false, default: false
  end
end
