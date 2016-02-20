Given(/^there is a game$/) do
  @game = GameTestHelper.create_game
end

Given(/^the user is a GM for the game$/) do
  GameTestHelper.add_gamesmaster @user, to: @game
end

Given(/^the game is in the future$/) do
  GameTestHelper.set_date Date.today + 7.days, of: @game
end

Given(/^the game is in the past$/) do
  GameTestHelper.set_date Date.today - 7.days, of: @game
end

Given(/^the game debrief has been started$/) do
  GameTestHelper.start_debriefing @game
end

When(/^the user publishes the brief for the game$/) do
  GamePage.new.visit_page(game_path(@game)).and.publish_briefs
end

When(/^the user publishes the debrief for the game$/) do
  GamePage.new.visit_page(game_path(@game)).and.finish_debrief
end

# Everything below this point is deprecated

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
  if field == "Last Updated"
    page.find("div#record#{id}").find("p.record_header").should have_content(field)
    page.find("div#record#{id}").find("p.record_header").should have_content(value)
  else
    page.find("div#record#{id}").find("div.#{field.gsub(/(\W)/, '').underscore}").find("span").should have_content(field)
    page.find("div#record#{id}").find("div.#{field.gsub(/(\W)/, '').underscore}").find("div.record_content").find("p").should have_content(value)
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
