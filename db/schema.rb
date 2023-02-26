# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_02_19_181323) do
  create_view "current_character_statuses", sql_definition: <<-SQL
      SELECT c.id AS id,
      c.id AS character_id,
      c.name AS name,
      COALESCE(c.starting_points, 0) + COALESCE(d.points, 0) + COALESCE(mps.points, 0) + COALESCE(cpa.points, 0) AS points,
      COALESCE(c.starting_death_thresholds, 0) + COALESCE(dta.death_thresholds, 0) - COALESCE(d.deaths, 0) AS death_thresholds,
      COALESCE(
          (
              SELECT id
              FROM guild_memberships gm
              WHERE gm.character_id = c.id
                  AND approved = 1
              ORDER BY declared_on DESC,
                  id DESC
              LIMIT 1
          ), (
              SELECT id
              FROM guild_memberships gm
              WHERE gm.character_id = c.id
              ORDER BY declared_on DESC,
                  id DESC
              LIMIT 1
          )
      ) AS guild_membership
  FROM characters c
      LEFT JOIN (
          SELECT c.id AS id,
              cast(
                  (
                      total(
                          COALESCE(d.base_points, g.player_points_base) + COALESCE(d.points_modifier, 0)
                      )
                  ) AS INTEGER
              ) AS points,
              cast((total(COALESCE(d.deaths, 0))) AS INTEGER) AS deaths
          FROM characters c
              INNER JOIN debriefs d ON d.character_id = c.id
              INNER JOIN games g ON d.game_id = g.id
          WHERE g.debrief_started = 1
              AND g.open = 0
              AND g.start_date >= c.declared_on
          GROUP BY c.id
      ) d ON c.id = d.id
      LEFT JOIN (
          SELECT c.id AS id,
              cast((total(mps.character_points_gained)) AS INTEGER) AS points
          FROM characters c
              INNER JOIN monster_point_spends mps ON mps.character_id = c.id
          WHERE mps.spent_on >= c.declared_on
          GROUP BY c.id
      ) mps ON c.id = mps.id
      LEFT JOIN (
          SELECT c.id AS id,
              cast((total(cpa.points)) AS INTEGER) AS points
          FROM characters c
              INNER JOIN character_point_adjustments cpa ON cpa.character_id = c.id
          WHERE cpa.declared_on >= c.declared_on
              AND cpa.approved = 1
          GROUP BY c.id
      ) cpa ON c.id = cpa.id
      LEFT JOIN (
          SELECT c.id AS id,
              cast((total(dta.change)) AS INTEGER) AS death_thresholds
          FROM characters c
              INNER JOIN death_threshold_adjustments dta ON dta.character_id = c.id
          WHERE dta.declared_on >= c.declared_on
              AND dta.approved = 1
          GROUP BY c.id
      ) dta ON c.id = dta.id
  SQL
  
  create_table "acceptables", force: :cascade do |t|
    t.string   "flavour",    :limit=>255, :null=>false
    t.text     "text",       :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acceptances", force: :cascade do |t|
    t.integer  "acceptable_id", :index=>{:name=>"index_acceptances_on_acceptable_id"}
    t.integer  "user_id",       :index=>{:name=>"index_acceptances_on_user_id"}
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ar_internal_metadata", primary_key: "key", id: :string, force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "board_visits", force: :cascade do |t|
    t.integer  "board_id",   :null=>false
    t.integer  "user_id",    :null=>false
    t.datetime "last_visit", :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", force: :cascade do |t|
    t.string   "name",         :limit=>255, :null=>false
    t.boolean  "in_character", :default=>false, :null=>false
    t.text     "blurb"
    t.integer  "order",        :null=>false
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed",       :default=>false, :null=>false
  end

  create_table "campaign_games_masters", id: false, force: :cascade do |t|
    t.integer  "campaign_id", :null=>false
    t.integer  "user_id",     :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "name",       :limit=>255, :null=>false
    t.boolean  "current",    :default=>false, :null=>false
    t.date     "start_date", :null=>false
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns_games", id: false, force: :cascade do |t|
    t.integer  "campaign_id", :null=>false
    t.integer  "game_id",     :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "caterers", id: false, force: :cascade do |t|
    t.integer "game_id", :null=>false, :index=>{:name=>"index_caterers_on_game_id_and_user_id", :with=>["user_id"]}
    t.integer "user_id", :null=>false
  end

  create_table "character_point_adjustments", force: :cascade do |t|
    t.integer  "character_id",   :null=>false, :index=>{:name=>"index_character_point_adjustments_on_character_id"}
    t.integer  "points",         :null=>false
    t.string   "reason",         :limit=>255, :null=>false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "declared_on",    :index=>{:name=>"index_character_point_adjustments_on_declared_on"}
    t.string   "comment",        :limit=>255
  end

  create_table "characters", force: :cascade do |t|
    t.integer  "user_id",                   :null=>false, :index=>{:name=>"index_characters_on_user_id"}
    t.string   "name",                      :limit=>255, :null=>false
    t.integer  "race_id",                   :null=>false
    t.integer  "guild_id"
    t.integer  "guild_start_points"
    t.integer  "starting_points",           :default=>20, :null=>false
    t.integer  "starting_florins",          :default=>0, :null=>false
    t.integer  "starting_death_thresholds", :null=>false
    t.text     "biography"
    t.date     "date_of_birth"
    t.boolean  "date_of_birth_public"
    t.text     "address"
    t.string   "title",                     :limit=>255
    t.string   "state",                     :limit=>255, :default=>"active", :null=>false
    t.text     "notes"
    t.date     "declared_on",               :default=>"2010-04-19", :null=>false
    t.integer  "approved_by_id"
    t.date     "approved_on"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
    t.text     "gm_notes"
    t.text     "player_notes"
    t.boolean  "preferred_character",       :default=>false, :null=>false
    t.string   "comment",                   :limit=>255
    t.boolean  "no_title",                  :default=>false, :null=>false
  end

  create_table "credits", force: :cascade do |t|
    t.integer  "transaction_id",  :null=>false, :index=>{:name=>"index_credits_on_transaction_id", :unique=>true}
    t.integer  "character_id",    :index=>{:name=>"index_credits_on_character_id"}
    t.string   "other_recipient", :limit=>255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "death_threshold_adjustments", force: :cascade do |t|
    t.integer  "character_id",   :null=>false, :index=>{:name=>"index_death_threshold_adjustments_on_character_id"}
    t.integer  "change",         :null=>false
    t.string   "reason",         :limit=>255, :null=>false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "declared_on",    :index=>{:name=>"index_death_threshold_adjustments_on_declared_on"}
    t.string   "comment",        :limit=>255
  end

  create_table "debits", force: :cascade do |t|
    t.integer  "transaction_id", :null=>false, :index=>{:name=>"index_debits_on_transaction_id", :unique=>true}
    t.integer  "character_id",   :index=>{:name=>"index_debits_on_character_id"}
    t.string   "other_source",   :limit=>255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debriefs", force: :cascade do |t|
    t.integer  "game_id",         :null=>false, :index=>{:name=>"index_debriefs_on_game_id"}
    t.integer  "user_id",         :null=>false, :index=>{:name=>"index_debriefs_on_user_id"}
    t.integer  "character_id",    :index=>{:name=>"index_debriefs_on_character_id"}
    t.integer  "base_points"
    t.integer  "points_modifier"
    t.text     "remarks"
    t.integer  "money_modifier"
    t.integer  "deaths"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loot"
  end

  create_table "food_categories", force: :cascade do |t|
    t.string "description", :limit=>255, :null=>false
  end

  create_table "food_choices", force: :cascade do |t|
    t.integer "food_options_id",     :index=>{:name=>"index_food_choices_on_food_options_id"}
    t.integer "game_attendances_id", :index=>{:name=>"index_food_choices_on_game_attendances_id"}
  end

  create_table "food_options", force: :cascade do |t|
    t.integer  "game_id",              :null=>false
    t.string   "name",                 :limit=>255, :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "food_category_id",     :index=>{:name=>"index_food_options_on_food_category_id"}
    t.integer  "food_sub_category_id", :index=>{:name=>"index_food_options_on_food_sub_category_id"}
  end

  create_table "food_sub_categories", force: :cascade do |t|
    t.string "description", :limit=>255, :null=>false
  end

  create_table "game_applications", force: :cascade do |t|
    t.integer  "game_id",    :null=>false
    t.integer  "user_id",    :null=>false
    t.text     "details",    :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved"
    t.string   "comment",    :limit=>255
  end

  create_table "game_attendances", force: :cascade do |t|
    t.integer  "game_id",       :null=>false, :index=>{:name=>"index_game_attendances_on_game_id"}
    t.integer  "user_id",       :null=>false
    t.boolean  "want_food"
    t.integer  "character_id"
    t.string   "attend_state",  :limit=>255, :null=>false
    t.string   "confirm_state", :limit=>255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes",         :limit=>255
    t.string   "food_notes",    :limit=>255
  end

  create_table "games", force: :cascade do |t|
    t.string   "title",               :limit=>255
    t.integer  "lower_rank"
    t.integer  "upper_rank"
    t.text     "ic_brief"
    t.text     "ooc_brief"
    t.text     "ic_debrief"
    t.text     "ooc_debrief"
    t.integer  "player_points_base"
    t.integer  "player_money_base"
    t.integer  "monster_points_base"
    t.date     "start_date",          :null=>false, :index=>{:name=>"index_games_on_start_date"}
    t.date     "end_date"
    t.time     "meet_time"
    t.time     "start_time"
    t.boolean  "open",                :null=>false
    t.string   "notes",               :limit=>255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "debrief_started",     :default=>false, :null=>false
    t.boolean  "non_stats",           :default=>false, :null=>false
    t.boolean  "attendance_only",     :default=>false, :null=>false
    t.string   "food_notes",          :limit=>255
    t.datetime "food_cutoff"
  end

  create_table "games_masters", id: false, force: :cascade do |t|
    t.integer  "game_id",    :null=>false, :index=>{:name=>"index_games_masters_on_game_id"}
    t.integer  "user_id",    :null=>false, :index=>{:name=>"index_games_masters_on_user_id"}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guild_branches", force: :cascade do |t|
    t.string   "name",         :limit=>255, :null=>false
    t.integer  "guild_id",     :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "branch_title", :limit=>255
  end

  create_table "guild_memberships", force: :cascade do |t|
    t.integer  "character_id",    :index=>{:name=>"index_guild_memberships_on_character_id"}
    t.integer  "guild_id"
    t.integer  "guild_branch_id"
    t.boolean  "provisional"
    t.date     "declared_on",     :index=>{:name=>"index_guild_memberships_on_declared_on"}
    t.integer  "start_points"
    t.boolean  "approved"
    t.datetime "approved_at"
    t.integer  "approved_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment",         :limit=>255
  end

  create_table "guilds", force: :cascade do |t|
    t.string   "name",             :limit=>255, :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tithe_percentage"
    t.boolean  "proscribed"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "board_id",          :null=>false
    t.integer  "user_id",           :null=>false
    t.string   "name",              :limit=>255
    t.text     "message",           :null=>false
    t.integer  "character_id"
    t.integer  "last_edited_by_id"
    t.boolean  "deleted",           :default=>false, :null=>false
    t.string   "request_uuid",      :limit=>255, :null=>false
    t.datetime "created_at",        :index=>{:name=>"index_messages_on_created_at"}
    t.datetime "updated_at"
  end

  create_table "monster_point_adjustments", force: :cascade do |t|
    t.integer  "user_id",        :null=>false, :index=>{:name=>"index_monster_point_adjustments_on_user_id"}
    t.integer  "points",         :null=>false
    t.string   "reason",         :limit=>255, :null=>false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "declared_on",    :index=>{:name=>"index_monster_point_adjustments_on_declared_on"}
    t.string   "comment",        :limit=>255
  end

  create_table "monster_point_declarations", force: :cascade do |t|
    t.integer  "user_id",        :null=>false, :index=>{:name=>"index_monster_point_declarations_on_user_id", :unique=>true}
    t.integer  "points",         :null=>false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "declared_on",    :index=>{:name=>"index_monster_point_declarations_on_declared_on"}
    t.string   "comment",        :limit=>255
  end

  create_table "monster_point_spends", force: :cascade do |t|
    t.integer  "character_id",            :index=>{:name=>"index_monster_point_spends_on_character_id"}
    t.integer  "monster_points_spent"
    t.date     "spent_on",                :index=>{:name=>"index_monster_point_spends_on_spent_on"}
    t.integer  "character_points_gained"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",             :limit=>50, :null=>false
    t.text     "content",           :null=>false
    t.boolean  "show_to_non_users", :default=>true, :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "role_id",    :null=>false
    t.integer  "user_id",    :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", force: :cascade do |t|
    t.string   "name",             :limit=>255, :null=>false
    t.integer  "death_thresholds", :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "rolename",   :limit=>255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin_only", :default=>false, :null=>false
    t.boolean  "system",     :default=>false, :null=>false
  end

  create_table "sidebar_categories", force: :cascade do |t|
    t.string   "name",                      :limit=>255
    t.integer  "order"
    t.boolean  "show_for_non_users"
    t.boolean  "show_for_admin_users_only"
    t.boolean  "editable",                  :default=>true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "always_open",               :default=>false
  end

  create_table "sidebar_entries", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "sidebar_category_id"
    t.integer  "parent_entry_id"
    t.string   "url",                 :limit=>255
    t.integer  "order",               :null=>false
    t.string   "name",                :limit=>50, :null=>false
    t.boolean  "editable",            :default=>true, :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titles", force: :cascade do |t|
    t.string   "name",       :limit=>255, :null=>false
    t.integer  "guild_id",   :null=>false
    t.integer  "points",     :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.date     "transaction_date", :null=>false, :index=>{:name=>"index_transactions_on_transaction_date"}
    t.integer  "value",            :null=>false
    t.string   "description",      :limit=>255, :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                   :limit=>40, :null=>false, :index=>{:name=>"index_users_on_username", :unique=>true}
    t.string   "name",                       :limit=>100, :default=>"", :null=>false
    t.string   "email",                      :limit=>100, :index=>{:name=>"index_users_on_email"}
    t.string   "encrypted_password",         :limit=>128, :default=>""
    t.string   "password_salt",              :limit=>40, :default=>""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",             :limit=>40
    t.datetime "remember_token_expires_at"
    t.string   "confirmation_token",         :limit=>40, :index=>{:name=>"index_users_on_confirmation_token", :unique=>true}
    t.datetime "confirmed_at"
    t.string   "state",                      :limit=>255, :default=>"passive"
    t.datetime "approved_at"
    t.datetime "deleted_at"
    t.string   "reset_password_token",       :limit=>40, :index=>{:name=>"index_users_on_reset_password_token", :unique=>true}
    t.boolean  "is_admin",                   :default=>false, :null=>false
    t.datetime "last_login"
    t.integer  "starting_monster_points",    :default=>0
    t.datetime "monster_points_declared_at"
    t.string   "mobile_number",              :limit=>255
    t.string   "contact_name",               :limit=>255
    t.string   "contact_number",             :limit=>255
    t.string   "medical_notes",              :limit=>255
    t.string   "notes",                      :limit=>255
    t.datetime "confirmation_sent_at"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",              :default=>0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",         :limit=>255
    t.string   "last_sign_in_ip",            :limit=>255
    t.string   "food_notes",                 :limit=>255
    t.datetime "emergency_last_updated"
  end

end
