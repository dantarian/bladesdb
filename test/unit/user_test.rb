require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = make_user
    make_race
    @character = make_character(@user)
  end

  test "games_gmed gives correct count with no games" do
    assert_equal(0, @user.games_gmed)
    assert_equal(0, @user.games_gmed_ever)
  end

  test "games_gmed gives correct count with no games GMed" do
    make_game

    assert_equal(0, @user.games_gmed)
    assert_equal(0, @user.games_gmed_ever)
  end

  test "games_gmed gives correct count with one game GMed this year" do
    game = make_game
    game.gamesmasters << @user
    game.save

    assert_equal(1, @user.games_gmed)
    assert_equal(1, @user.games_gmed_ever)
  end

  test "games_gmed gives correct count with one game GMed last year" do
    game = make_game(start_date: 1.year.ago)
    game.gamesmasters << @user
    game.save

    assert_equal(0, @user.games_gmed)
    assert_equal(1, @user.games_gmed_ever)
  end

  test "game_played gives correct count with no games" do
    assert_equal(0, @user.games_played)
    assert_equal(0, @user.games_played_ever)
  end

  test "game_played gives correct count with no games played" do
    make_game

    assert_equal(0, @user.games_played)
    assert_equal(0, @user.games_played_ever)
  end

  test "games_played gives correct count with one game played this year" do
    game = make_game
    debrief(game)
    add_character_to_debrief(game, @character)
    
    assert_equal(1, @user.games_played)
    assert_equal(1, @user.games_played_ever)
  end

  test "games_played gives correct count with one game played last year" do
    game = make_game(start_date: 1.year.ago)
    debrief(game)
    add_character_to_debrief(game, @character)
    
    assert_equal(0, @user.games_played)
    assert_equal(1, @user.games_played_ever)
  end

  private

  def make_user(username: "normal_user", name: "Normal User", email: "test@example.com", password: "some_password", state: "active")
    User.create_with(name: name, email: email, password: password, state: state).find_or_create_by(username: username)
  end

  def make_game(title: "New Game", start_date: (Date.yesterday), end_date: nil, meet_time: "11:00", start_time: "12:00", open: true, attendance_only: false)
    Game.create_with(start_date: start_date, end_date: end_date, meet_time: meet_time, start_time: start_time, open: open, attendance_only: attendance_only).find_or_create_by(title: title)
  end

  def make_race
    Race.create!(name: "Human", death_thresholds: 10)
  end

  def make_character(user, name: "Testy McTesterson", race: Race.first, starting_points: 20, starting_florins: 0, starting_death_thresholds: 10, state: "active", title: "", no_title: false, declared_on: 5.years.ago)
    character = user.characters.create_with(race: race, starting_points: starting_points, starting_florins: starting_florins, starting_death_thresholds: starting_death_thresholds, state: state, title: title, declared_on: declared_on, no_title: no_title).find_or_create_by!(name: name)
    guild_membership = character.guild_memberships.build
    guild_membership.character = character
    guild_membership.start_points = 0
    guild_membership.declared_on = character.declared_on
    guild_membership.provisional = false
    guild_membership.approved = true
    character.save!
    character
  end

  def debrief(game, player_points: 10, monster_points: 5, money: 10)
    game.setup_debrief
    game.debrief_started = true
    game.player_points_base = player_points
    game.monster_points_base = monster_points
    game.player_money_base = money
    game.open = false
    game.save!
  end

  def add_character_to_debrief(game, character, points: 10)
    debrief = game.debriefs.find_or_create_by(user: character.user, character: character)
    debrief.points_modifier = points - game.player_points_base
    game.save!
  end


end

