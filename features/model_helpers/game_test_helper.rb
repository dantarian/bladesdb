module GameTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions

  def create_game(opts = {})
    game = Game.new(title: opts[:title] || "New Game",
                    start_date: opts[:start_date] || (Date.today + 1), 
                    meet_time: opts[:meet_time] || "11:00", 
                    start_time: opts[:start_time] || "12:00")
    game.save
    game
  end

  def add_gamesmaster(gamesmaster, to)
    to.gamesmasters << gamesmaster
  end

  def set_date(date, of)
    of.start_date = date
    of.save
  end
  
  def start_debriefing(game)
    game.setup_debrief
    game.debrief_started = true
    game.player_points_base = 10
    game.monster_points_base = 5
    game.player_money_base = 10
    game.save
  end
end
