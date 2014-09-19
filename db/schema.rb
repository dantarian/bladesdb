# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140919201337) do

  create_table "board_visits", force: true do |t|
    t.integer  "board_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "last_visit", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", force: true do |t|
    t.string   "name",                         null: false
    t.boolean  "in_character", default: false, null: false
    t.text     "blurb"
    t.integer  "order",                        null: false
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaign_games_masters", id: false, force: true do |t|
    t.integer  "campaign_id", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", force: true do |t|
    t.string   "name",                       null: false
    t.boolean  "current",    default: false, null: false
    t.date     "start_date",                 null: false
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns_games", id: false, force: true do |t|
    t.integer  "campaign_id", null: false
    t.integer  "game_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "caterers", id: false, force: true do |t|
    t.integer "game_id", null: false
    t.integer "user_id", null: false
    t.index ["game_id", "user_id"], :name => "index_caterers_on_game_id_and_user_id"
  end

  create_table "character_point_adjustments", force: true do |t|
    t.integer  "character_id",   null: false
    t.integer  "points",         null: false
    t.string   "reason",         null: false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "declared_on"
    t.index ["character_id"], :name => "index_character_point_adjustments_on_character_id"
    t.index ["declared_on"], :name => "index_character_point_adjustments_on_declared_on"
  end

  create_table "characters", force: true do |t|
    t.integer  "user_id",                                          null: false
    t.string   "name",                                             null: false
    t.integer  "race_id",                                          null: false
    t.integer  "guild_id"
    t.integer  "guild_start_points"
    t.integer  "starting_points",           default: 20,           null: false
    t.integer  "starting_florins",          default: 0,            null: false
    t.integer  "starting_death_thresholds",                        null: false
    t.text     "biography"
    t.date     "date_of_birth"
    t.boolean  "date_of_birth_public"
    t.text     "address"
    t.string   "title"
    t.string   "state",                     default: "active",     null: false
    t.text     "notes"
    t.date     "declared_on",               default: '2010-04-19', null: false
    t.integer  "approved_by_id"
    t.date     "approved_on"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "branch_id"
    t.text     "gm_notes"
    t.index ["user_id"], :name => "index_characters_on_user_id"
  end

  create_table "credits", force: true do |t|
    t.integer  "transaction_id",  null: false
    t.integer  "character_id"
    t.string   "other_recipient"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["character_id"], :name => "index_credits_on_character_id"
    t.index ["transaction_id"], :name => "index_credits_on_transaction_id", :unique => true
  end

  create_table "death_threshold_adjustments", force: true do |t|
    t.integer  "character_id",   null: false
    t.integer  "change",         null: false
    t.string   "reason",         null: false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "declared_on"
    t.index ["character_id"], :name => "index_death_threshold_adjustments_on_character_id"
    t.index ["declared_on"], :name => "index_death_threshold_adjustments_on_declared_on"
  end

  create_table "debriefs", force: true do |t|
    t.integer  "game_id",         null: false
    t.integer  "user_id",         null: false
    t.integer  "character_id"
    t.integer  "base_points"
    t.integer  "points_modifier"
    t.text     "remarks"
    t.integer  "money_modifier"
    t.integer  "deaths"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loot"
    t.index ["character_id"], :name => "index_debriefs_on_character_id"
    t.index ["game_id"], :name => "index_debriefs_on_game_id"
    t.index ["user_id"], :name => "index_debriefs_on_user_id"
  end

  create_table "games", force: true do |t|
    t.string   "title"
    t.integer  "lower_rank"
    t.integer  "upper_rank"
    t.text     "ic_brief"
    t.text     "ooc_brief"
    t.text     "ic_debrief"
    t.text     "ooc_debrief"
    t.integer  "player_points_base"
    t.integer  "player_money_base"
    t.integer  "monster_points_base"
    t.date     "start_date",                          null: false
    t.date     "end_date"
    t.time     "meet_time"
    t.time     "start_time"
    t.boolean  "open",                default: true,  null: false
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "debrief_started",     default: false, null: false
    t.boolean  "non_stats",           default: false, null: false
    t.boolean  "attendance_only",     default: false, null: false
    t.string   "food_notes"
    t.datetime "food_cutoff"
    t.index ["start_date"], :name => "index_games_on_start_date"
  end

  create_table "guild_memberships", force: true do |t|
    t.integer  "character_id"
    t.integer  "guild_id"
    t.integer  "guild_branch_id"
    t.boolean  "provisional"
    t.date     "declared_on"
    t.integer  "start_points"
    t.boolean  "approved"
    t.datetime "approved_at"
    t.integer  "approved_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["character_id"], :name => "index_guild_memberships_on_character_id"
    t.index ["declared_on"], :name => "index_guild_memberships_on_declared_on"
  end

  create_table "monster_point_spends", force: true do |t|
    t.integer  "character_id"
    t.integer  "monster_points_spent"
    t.date     "spent_on"
    t.integer  "character_points_gained"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["character_id"], :name => "index_monster_point_spends_on_character_id"
    t.index ["spent_on"], :name => "index_monster_point_spends_on_spent_on"
  end

  create_view "current_character_status", "SELECT\n        c.id AS id,\n        c.id AS character_id,\n        c.name AS name,\n        COALESCE(c.starting_points, 0) + COALESCE(d.points, 0) + COALESCE(mps.points, 0) + COALESCE(cpa.points, 0) AS points,\n        COALESCE(c.starting_death_thresholds, 0) + COALESCE(dta.death_thresholds, 0) - COALESCE(d.deaths, 0) AS death_thresholds,\n        COALESCE( (SELECT id FROM guild_memberships gm WHERE gm.character_id = c.id AND approved = 't' ORDER BY declared_on DESC, id DESC LIMIT 1), (SELECT id FROM guild_memberships gm WHERE gm.character_id = c.id ORDER BY declared_on DESC, id DESC LIMIT 1)) AS guild_membership\n        FROM\n          characters c\n          LEFT JOIN\n          (SELECT \n            c.id AS id, \n            cast((total(COALESCE(d.base_points, g.player_points_base) + COALESCE(d.points_modifier, 0))) AS INTEGER) AS points,\n            cast((total(COALESCE(d.deaths, 0))) AS INTEGER) AS deaths\n            FROM\n              characters c\n              INNER JOIN debriefs d ON d.character_id = c.id\n              INNER JOIN games g ON d.game_id = g.id\n            WHERE\n              g.debrief_started = 't'\n              AND\n              g.open = 'f'\n              AND\n              g.start_date >= c.declared_on\n            GROUP BY c.id) d ON c.id = d.id\n          LEFT JOIN\n          (SELECT\n            c.id AS id,\n            cast((total(mps.character_points_gained)) AS INTEGER) AS points\n            FROM\n              characters c\n              INNER JOIN monster_point_spends mps ON mps.character_id = c.id\n            WHERE\n              mps.spent_on >= c.declared_on\n            GROUP BY c.id) mps ON c.id = mps.id\n          LEFT JOIN\n          (SELECT\n            c.id AS id,\n            cast((total(cpa.points)) AS INTEGER) AS points\n            FROM\n              characters c\n              INNER JOIN character_point_adjustments cpa ON cpa.character_id = c.id\n            WHERE\n              cpa.declared_on >= c.declared_on\n              AND\n              cpa.approved = 't'\n            GROUP BY c.id) cpa ON c.id = cpa.id\n          LEFT JOIN\n          (SELECT\n            c.id AS id,\n            cast((total(dta.change)) AS INTEGER) AS death_thresholds\n            FROM\n              characters c\n              INNER JOIN death_threshold_adjustments dta ON dta.character_id = c.id\n            WHERE\n              dta.declared_on >= c.declared_on\n              AND\n              dta.approved = 't'\n            GROUP BY c.id) dta ON c.id = dta.id", :force => true
  create_table "debits", force: true do |t|
    t.integer  "transaction_id", null: false
    t.integer  "character_id"
    t.string   "other_source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["character_id"], :name => "index_debits_on_character_id"
    t.index ["transaction_id"], :name => "index_debits_on_transaction_id", :unique => true
  end

  create_table "food_categories", force: true do |t|
    t.string "description", null: false
  end

  create_table "food_choices", force: true do |t|
    t.integer "food_options_id"
    t.integer "game_attendances_id"
    t.index ["food_options_id"], :name => "index_food_choices_on_food_options_id"
    t.index ["game_attendances_id"], :name => "index_food_choices_on_game_attendances_id"
  end

  create_table "food_options", force: true do |t|
    t.integer  "game_id",              null: false
    t.string   "name",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "food_category_id"
    t.integer  "food_sub_category_id"
    t.index ["food_category_id"], :name => "index_food_options_on_food_category_id"
    t.index ["food_sub_category_id"], :name => "index_food_options_on_food_sub_category_id"
  end

  create_table "food_sub_categories", force: true do |t|
    t.string "description", null: false
  end

  create_table "game_applications", force: true do |t|
    t.integer  "game_id",    null: false
    t.integer  "user_id",    null: false
    t.text     "details",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_attendances", force: true do |t|
    t.integer  "game_id",       null: false
    t.integer  "user_id",       null: false
    t.boolean  "want_food"
    t.integer  "character_id"
    t.string   "attend_state",  null: false
    t.string   "confirm_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes"
    t.string   "food_notes"
    t.index ["game_id"], :name => "index_game_attendances_on_game_id"
  end

  create_table "games_masters", id: false, force: true do |t|
    t.integer  "game_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["game_id"], :name => "index_games_masters_on_game_id"
    t.index ["user_id"], :name => "index_games_masters_on_user_id"
  end

  create_table "guild_branches", force: true do |t|
    t.string   "name",       null: false
    t.integer  "guild_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guilds", force: true do |t|
    t.string   "name",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tithe_percentage"
    t.boolean  "proscribed"
  end

  create_table "messages", force: true do |t|
    t.integer  "board_id",                          null: false
    t.integer  "user_id",                           null: false
    t.string   "name"
    t.text     "message",                           null: false
    t.integer  "character_id"
    t.integer  "last_edited_by_id"
    t.boolean  "deleted",           default: false, null: false
    t.string   "request_uuid",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], :name => "index_messages_on_created_at"
  end

  create_table "monster_point_adjustments", force: true do |t|
    t.integer  "user_id",        null: false
    t.integer  "points",         null: false
    t.string   "reason",         null: false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "declared_on"
    t.index ["declared_on"], :name => "index_monster_point_adjustments_on_declared_on"
    t.index ["user_id"], :name => "index_monster_point_adjustments_on_user_id"
  end

  create_table "monster_point_declarations", force: true do |t|
    t.integer  "user_id",        null: false
    t.integer  "points",         null: false
    t.integer  "approved_by_id"
    t.datetime "approved_at"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "declared_on"
    t.index ["declared_on"], :name => "index_monster_point_declarations_on_declared_on"
    t.index ["user_id"], :name => "index_monster_point_declarations_on_user_id", :unique => true
  end

  create_table "pages", force: true do |t|
    t.string   "title",             limit: 50,                null: false
    t.text     "content",                                     null: false
    t.boolean  "show_to_non_users",            default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: true do |t|
    t.integer  "role_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", force: true do |t|
    t.string   "name",             null: false
    t.integer  "death_thresholds", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "rolename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sidebar_categories", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.boolean  "show_for_non_users"
    t.boolean  "show_for_admin_users_only"
    t.boolean  "editable",                  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "always_open",               default: false
  end

  create_table "sidebar_entries", force: true do |t|
    t.integer  "page_id"
    t.integer  "sidebar_category_id"
    t.integer  "parent_entry_id"
    t.string   "url"
    t.integer  "order",                                         null: false
    t.string   "name",                limit: 50,                null: false
    t.boolean  "editable",                       default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titles", force: true do |t|
    t.string   "name",       null: false
    t.integer  "guild_id",   null: false
    t.integer  "points",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.date     "transaction_date", null: false
    t.integer  "value",            null: false
    t.string   "description",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["transaction_date"], :name => "index_transactions_on_transaction_date"
  end

  create_table "users", force: true do |t|
    t.string   "username",                   limit: 40,                      null: false
    t.string   "name",                       limit: 100, default: "",        null: false
    t.string   "email",                      limit: 100
    t.string   "encrypted_password",         limit: 128, default: ""
    t.string   "password_salt",              limit: 40,  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",             limit: 40
    t.datetime "remember_token_expires_at"
    t.string   "confirmation_token",         limit: 40
    t.datetime "confirmed_at"
    t.string   "state",                                  default: "passive"
    t.datetime "approved_at"
    t.datetime "deleted_at"
    t.string   "reset_password_token",       limit: 40
    t.boolean  "is_admin",                               default: false,     null: false
    t.datetime "last_login"
    t.integer  "starting_monster_points",                default: 0
    t.datetime "monster_points_declared_at"
    t.string   "mobile_number"
    t.string   "contact_name"
    t.string   "contact_number"
    t.string   "medical_notes"
    t.string   "notes"
    t.datetime "confirmation_sent_at"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "food_notes"
    t.datetime "emergency_last_updated"
    t.index ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
    t.index ["email"], :name => "index_users_on_email"
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["username"], :name => "index_users_on_username", :unique => true
  end

end
