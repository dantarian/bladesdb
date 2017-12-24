module GameTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions

  def create_game(title: "New Game", start_date: (Date.today + 1), end_date: nil, meet_time: "11:00", start_time: "12:00", open: true, attendance_only: false)
    Game.create_with(start_date: start_date, end_date: end_date, meet_time: meet_time, start_time: start_time, open: open, attendance_only: attendance_only).find_or_create_by(title: title)
  end

  def add_gamesmaster(gamesmaster, to: nil)
    to.gamesmasters << gamesmaster
  end

  def add_player(player, character, to: nil)
    to.game_attendances.create_with(character: character, attend_state: "playing", confirm_state: "requested").find_or_create_by(user: player)
  end

  def add_monster(monster, to: nil)
    to.game_attendances.create_with(attend_state: "monstering").find_or_create_by(user: monster)
  end

  def add_non_attendee(nonattendee, to: nil)
    to.game_attendances.create_with(attend_state: "not_attending").find_or_create_by(user: nonattendee)
  end

  def add_attendee(attendee, to: nil)
    to.game_attendances.create_with(attend_state: "attending").find_or_create_by(user: attendee)
  end

  def make_application(user, details: "This is a game.", to: nil)
    to.game_applications.create_with(details: details).find_or_create_by(user: user)
  end

  def clear_applications(from: nil)
    from.game_applications.clear
    from.save!
    from
  end

  def set_open(game, open)
    game.open = open
    game.save
    game
  end

  def set_date(date, of: nil)
    of.start_date = date
    of.save
    of
  end

  def set_max_rank(of: nil, to: nil)
    of.upper_rank = to.to_i * 10
    of.save
  end

  def set_non_stats(game)
    game.non_stats = true
    game.save
  end

  def start_debriefing(game)
    game.setup_debrief
    game.debrief_started = true
    game.player_points_base = 10
    game.monster_points_base = 5
    game.player_money_base = 10
    game.save
    game
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

  def create_game_next_sunday
    create_game(start_date: next_sunday)
  end

  def create_game_covering_next_sunday
    create_game(start_date: Date.today, end_date: next_sunday)
  end

  def create_game_covering_next_sunday_starting_yesterday
    create_game(start_date: Date.yesterday, end_date: next_sunday)
  end

  def next_sunday
    (Date.today.sunday > Date.today ? Date.today.sunday : Date.today.sunday + 7.days)
  end

  def create_debriefed_game_for_first_character(points)
    game = create_game(start_date: 14.days.ago)
    add_player(Character.first.user, Character.first, to: game)
    debrief(game, player_points: points)
    game
  end

  def create_another_debriefed_game_for_first_character(points)
    game = create_game(title: "Another Game", start_date: 7.days.ago)
    add_player(Character.first.user, Character.first, to: game)
    debrief(game, player_points: points)
    game
  end

  def create_debriefed_game_for_first_user_as_monster(points)
    game = create_game(title: "Monstered Game", start_date: 14.days.ago)
    add_monster(User.first, to: game)
    debrief(game, monster_points: points)
    game
  end

  def close_debrief(game)
    game.open = false
    game.save!
  end
end
