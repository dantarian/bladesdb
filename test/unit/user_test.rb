require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = make_user
    make_race
    @character = make_character(@user)
  end

  test "games_gmed gives correct count with no games" do
    assert_equal(0, @user.games_gmed, "games_gmed is non-zero with no games in the system")
    assert_equal(0, @user.games_gmed_ever, "games_gmed_ever is non-zero with no games in the system")
  end

  test "games_gmed gives correct count with no games GMed" do
    debrief(make_game)

    assert_equal(0, @user.games_gmed, "games_gmed is non-zero with no games GMed")
    assert_equal(0, @user.games_gmed_ever, "games_gmed_ever is non-zero with no games GMed")
  end

  test "games_gmed gives correct count with one game GMed this year" do
    game = make_game
    game.gamesmasters << @user
    game.save!
    debrief(game)

    assert_equal(1, @user.games_gmed, "games_gmed does not equal 1 when 1 normal game has been GMed")
    assert_equal(1, @user.games_gmed_ever, "games_gmed_ever does not equal 1 when 1 normal game has been GMed")
  end

  test "games_gmed gives correct count with one game GMed last year" do
    game = make_game(start_date: 1.year.ago)
    game.gamesmasters << @user
    game.save!
    debrief(game)

    assert_equal(0, @user.games_gmed, "games_gmed is non-zero when only GMed game is one year ago")
    assert_equal(1, @user.games_gmed_ever, "games_gmed_ever does not equal 1 when 1 normal game was GMed one year ago")
  end

  test "games_gmed does not count games played if not also GMing" do
    game = make_game
    debrief(game)
    add_character_to_debrief(game, @character)

    assert_equal(0, @user.games_gmed, "games_gmed is non-zero when only game was played and not GMed")
    assert_equal(0, @user.games_gmed_ever, "games_gmed_ever is non-zero when only game was played and not GMed")
  end

  test "games_gmed and games_played both count if game played and GMed" do
    game = make_game
    game.gamesmasters << @user
    game.save!
    debrief(game)
    add_character_to_debrief(game, @character)

    assert_equal(1, @user.games_gmed, "games_gmed does not equal 1 when 1 normal game has been both played and GMed")
    assert_equal(1, @user.games_gmed_ever, "games_gmed_ever does not equal 1 when 1 normal game has been both played and GMed")
    assert_equal(1, @user.games_played, "games_played does not equal 1 when 1 normal game has been both played and GMed")
    assert_equal(1, @user.games_played_ever, "games_played_ever does not equal 1 when 1 normal game has been both played and GMed")
  end

  test "games_gmed does not count games monstered" do
    game = make_game
    debrief(game)
    add_monster_to_debrief(game, @user)

    assert_equal(0, @user.games_gmed, "games_gmed is non-zero when only game was monstered and not GMed")
    assert_equal(0, @user.games_gmed_ever, "games_gmed_ever is non-zero when only game was monstered and not GMed")
  end

  test "games_gmed does not count games with a monter base of 0" do
    game = make_game
    game.gamesmasters << @user
    game.save!
    debrief(game, monster_points: 0)

    assert_equal(0, @user.games_gmed, "games_gmed is non-zero when the only game has 0 monster base")
    assert_equal(0, @user.games_gmed_ever, "games_gmed_ever is non-zero when the only game has 0 monster base")
  end

  test "game_played gives correct count with no games" do
    assert_equal(0, @user.games_played, "games_played is non-zero with no games in the system")
    assert_equal(0, @user.games_played_ever, "games_played_ever is non-zero with no games in the system")
  end

  test "game_played gives correct count with no games played" do
    debrief(make_game)

    assert_equal(0, @user.games_played, "games_played is non-zero with no games played")
    assert_equal(0, @user.games_played_ever, "games_played_ever is non-zero with no games played")
  end

  test "games_played gives correct count with one game played this year" do
    game = make_game
    debrief(game)
    add_character_to_debrief(game, @character)
    
    assert_equal(1, @user.games_played, "games_played does not equal 1 when 1 normal game has been played")
    assert_equal(1, @user.games_played_ever, "games_played_ever does not equal 1 when 1 normal game has been played")
  end

  test "games_played gives correct count with one game played last year" do
    game = make_game(start_date: 1.year.ago)
    debrief(game)
    add_character_to_debrief(game, @character)
    
    assert_equal(0, @user.games_played, "games_played is non-zero with no games played this year")
    assert_equal(1, @user.games_played_ever, "games_played_ever does not equal 1 when 1 normal game has been played a year ago")
  end

  test "games_played gives correct count with two characters played on the same game" do
    game = make_game
    debrief(game)
    add_character_to_debrief(game, @character)
    add_character_to_debrief(game, make_character(@user, name: "Second Character"))

    assert_equal(1, @user.games_played, "games_played does not equal 1 when 2 characters were played on the same game")
    assert_equal(1, @user.games_played_ever, "games_played_ever does not equal 1 when 2 characters were played on the same game")
  end

  test "games_played does not count games with a player base of 0" do
    game = make_game
    debrief(game, player_points: 0)
    add_character_to_debrief(game, @character)

    assert_equal(0, @user.games_played, "games_played is non-zero when the only game has 0 player base")
    assert_equal(0, @user.games_played_ever, "games_played_ever is non-zero when the only game has 0 player base")
  end

  test "games_played does not count games with a player debrief base of 0" do
    game = make_game
    debrief(game)
    add_character_to_debrief(game, @character, base_points: 0)

    assert_equal(0, @user.games_played, "games_played is non-zero when the only game has 0 player base")
    assert_equal(0, @user.games_played_ever, "games_played_ever is non-zero when the only game has 0 player base")
  end

  test "games_monstered gives correct count with no games" do
    assert_equal(0, @user.games_monstered, "games_monstered is non-zero with no games in the system")
    assert_equal(0, @user.games_monstered_ever, "games_monstered_ever is non-zero with no games in the system")
  end

  test "games_monstered gives correct count with no games monstered" do
    debrief(make_game)

    assert_equal(0, @user.games_monstered, "games_monstered is non-zero with no games monstered")
    assert_equal(0, @user.games_monstered_ever, "games_monstered_ever is non-zero with no games monstered")
  end

  test "games_monstered gives correct count with one game monstered this year" do
    game = make_game
    debrief(game)
    add_monster_to_debrief(game, @user)

    assert_equal(1, @user.games_monstered, "games_monstered does not equal 1 when 1 normal game monstered")
    assert_equal(1, @user.games_monstered_ever, "games_monstered_ever does not equal 1 when 1 normal game monstered")
  end

  test "games_monstered gives correct count with one game monstered last year" do
    game = make_game(start_date: 1.year.ago)
    debrief(game)
    add_monster_to_debrief(game, @user)

    assert_equal(0, @user.games_monstered, "games_monstered is non-zero with no games monstered this year")
    assert_equal(1, @user.games_monstered_ever, "games_monstered_ever does not equal 1 when 1 normal game monstered")
  end

  test "games_monstered gives correct count with one game GMed this year" do
    game = make_game
    game.gamesmasters << @user
    game.save!
    debrief(game)

    assert_equal(1, @user.games_monstered, "games_monstered does not equal 1 when 1 normal game GMed")
    assert_equal(1, @user.games_monstered_ever, "games_monstered_ever does not equal 1 when 1 normal game GMed")
  end

  test "games_monstered gives correct count with one game GMed last year" do
    game = make_game(start_date: 1.year.ago)
    game.gamesmasters << @user
    game.save!
    debrief(game)

    assert_equal(0, @user.games_monstered, "games_monstered is non-zero with no games GMed this year")
    assert_equal(1, @user.games_monstered_ever, "games_monstered_ever does not equal 1 when 1 normal game GMed")
  end

  test "games_monstered does not count games with a player base of 0" do
    game = make_game
    debrief(game, monster_points: 0)
    add_monster_to_debrief(game, @user)

    assert_equal(0, @user.games_monstered, "games_monstered is non-zero when the only game has 0 player base")
    assert_equal(0, @user.games_monstered_ever, "games_monstered_ever is non-zero when the only game has 0 player base")
  end

  test "games_monstered does not count games with a player debrief base of 0" do
    game = make_game
    debrief(game)
    add_monster_to_debrief(game, @user, base_points: 0)

    assert_equal(0, @user.games_monstered, "games_monstered is non-zero when the only game has 0 player base")
    assert_equal(0, @user.games_monstered_ever, "games_monstered_ever is non-zero when the only game has 0 player base")
  end

  test "games_played and games_monstered both count games that the user played and monstered" do
    game = make_game
    debrief(game)
    add_character_to_debrief(game, @character)
    add_monster_to_debrief(game, @user)
    
    assert_equal(1, @user.games_played, "games_played does not equal 1 when 1 normal game played and monstered")
    assert_equal(1, @user.games_played_ever, "games_played_ever does not equal 1 when 1 normal game played and monstered")
    assert_equal(1, @user.games_monstered, "games_monstered does not equal 1 when 1 normal game played and monstered")
    assert_equal(1, @user.games_monstered_ever, "games_monstered_ever does not equal 1 when 1 normal game played and monstered")
  end

  private

  def make_user(username: "normal_user", name: "Normal User", email: "test@example.com", password: "some_password", state: "active")
    User.create_with(name: name, email: email, password: password, password_confirmation: password, state: state).find_or_create_by!(username: username)
  end

  def make_game(title: "New Game", start_date: (Date.yesterday), end_date: nil, meet_time: "11:00", start_time: "12:00", open: true, attendance_only: false)
    Game.create_with(start_date: start_date, 
                     end_date: end_date, 
                     meet_time: meet_time, 
                     start_time: start_time, 
                     open: open, 
                     attendance_only: attendance_only)
      .find_or_create_by!(title: title)
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

  def add_character_to_debrief(game, character, points: 10, base_points: nil)
    debrief = game.debriefs.create(user: character.user, character: character, base_points: base_points)
    debrief.points_modifier = points - (base_points.nil? ? game.player_points_base : base_points)
    game.save!
  end

  def add_monster_to_debrief(game, user, points: 5, base_points: nil)
    debrief = game.debriefs.create(user: user, base_points: base_points)
    debrief.points_modifier = points - (base_points.nil? ? game.monster_points_base : base_points)
    game.save!
  end

end

