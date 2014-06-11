Given(/^there is a game$/) do
  @game = create_game
end

Given(/^(I am|they are?) a GM for the game$/) do |actor|
  if actor == "I am"
    add_gm(@user)
  else
    add_gm(@other_user)
  end
end

def create_game(opts = {})
  game = Game.new(start_date: opts[:start_date] || (Date.today + 1), meet_time: opts[:meet_time] || "11:00", start_time: opts[:start_time] || "12:00")
  game.save
  game
end

def add_gm(user)
  @game.gamesmasters << user
end