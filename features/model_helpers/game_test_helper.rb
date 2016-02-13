module GameTestHelper
  def create_game(opts = {})
    Game.new(start_date: opts[:start_date] || (Date.today + 1), 
             meet_time: opts[:meet_time] || "11:00", 
             start_time: opts[:start_time] || "12:00").save
  end

  def add_gamesmaster(gamesmaster, to)
    to.gamesmasters << gamesmaster
  end

  def set_date(date, of)
    of.start_date = date
    of.save
  end
end
