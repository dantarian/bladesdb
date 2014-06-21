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

Then(/^(I am|the other user is?) in the "(.*?)" section$/) do |actor, section|
  if actor == "I am"
    id = @user.id
  else
    id = @other_user.id
  end
  if section == "Player"
    page.find("div.players").find("div.record##id")
  elsif section == "Monster"
    page.find("div.monsters").find("div.record##id")
  elsif section == "GMs"
    page.find("div.gms").find("div.record##id")
  end
end

Then(/^(I|they?) have an? "(.*?)" record that says "(.*?)"$/) do |actor, field, value|
  if actor == "I"
    id = @user.id
  else
    id = @other_user.id
  end
  page.find("div#record#{id}").find("div.#{field.gsub(/(\W)/, '').underscore}").find("h4").should have_content(field)
  page.find("div#record#{id}").find("div.#{field.gsub(/(\W)/, '').underscore}").find("p").should have_content(value)
end

def create_game(opts = {})
  game = Game.new(start_date: opts[:start_date] || (Date.today + 1), meet_time: opts[:meet_time] || "11:00", start_time: opts[:start_time] || "12:00")
  game.save
  game
end

def add_gm(user)
  @game.gamesmasters << user
end