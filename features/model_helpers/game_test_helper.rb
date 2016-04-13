module GameTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions

  def create_game(title: "New Game", start_date: (Date.today + 1), meet_time: "11:00", start_time: "12:00")
    game = Game.create_with(start_date: start_date, meet_time: meet_time, start_time: start_time).find_or_create_by(title: title)
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

  def set_date(date, of: nil)
    of.start_date = date
    of.save
    of
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
end
