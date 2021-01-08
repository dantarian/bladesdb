class UpdateBooleanDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column_default :boards, :in_character, from: false, to: false
    change_column_default :boards, :closed, from: false, to: false
    change_column_default :campaigns, :current, from: false, to: false
    change_column_default :characters, :preferred_character, from: false, to: false
    change_column_default :characters, :no_title, from: false, to: false
    change_column_default :games, :debrief_started, from: false, to: false
    change_column_default :games, :non_stats, from: false, to: false
    change_column_default :games, :attendance_only, from: false, to: false
    change_column_default :messages, :deleted, from: false, to: false
    change_column_default :pages, :show_to_non_users, from: true, to: true
    change_column_default :roles, :admin_only, from: false, to: false
    change_column_default :roles, :system, from: false, to: false
    change_column_default :sidebar_categories, :editable, from: true, to: true
    change_column_default :sidebar_categories, :always_open, from: false, to: false
    change_column_default :sidebar_entries, :editable, from: true, to: true
    change_column_default :users, :is_admin, from: false, to: false
  end
end
