module GameTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions

  def create_game(opts = {})
    game = Game.new(title: opts[:title] || "New Game",
                    start_date: opts[:start_date] || (Date.today + 1), 
                    end_date: opts[:end_date] || nil,
                    meet_time: opts[:meet_time] || "11:00", 
                    start_time: opts[:start_time] || "12:00")
    game.save
    game
  end

  def add_gamesmaster(gamesmaster, to: nil)
    to.gamesmasters << gamesmaster
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
end
