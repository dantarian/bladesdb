Given(/^there is a game$/) do
  GameTestHelper.create_game
end

Given(/^the user is a GM for the game$/) do
  GameTestHelper.add_gamesmaster User.first, to: Game.first
end

Given(/^the other user is a player of the game$/) do
  user = UserTestHelper.create_or_find_another_user
  character = CharacterTestHelper.create_character(user)
  CharacterTestHelper.approve_character(user)
  GameTestHelper.add_player user, character, to: Game.first
end

Given(/^there is a GM for the game$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Gerald Mann", email: "gm@mail.com", username: "gm1")
  GameTestHelper.add_gamesmaster user, to: Game.first
end

Given(/^there is a player for the game$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Poppy Player", email: "player@mail.com", username: "player")
  character = CharacterTestHelper.create_character(user)
  CharacterTestHelper.approve_character(user)
  GameTestHelper.add_player user, character, to: Game.first
end

Given(/^there is a monster for the game$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Manfred Monster", email: "monster@mail.com", username: "monster")
  GameTestHelper.add_monster user, to: Game.first
end

Given(/^there is a non-attendee for the game$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Nick Albright", email: "na@mail.com", username: "not")
  GameTestHelper.add_non_attendee user, to: Game.first
end

Given(/^there is an attendee for the game$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Alan The Terrible", email: "att@mail.com", username: "att")
  GameTestHelper.add_attendee user, to: Game.first
end

Given(/^the game is in the future$/) do
  GameTestHelper.set_date Date.today + 7.days, of: Game.first
end

Given(/^the game is in the past$/) do
  GameTestHelper.set_date Date.today - 7.days, of: Game.first
end

Given(/^the game debrief has been started$/) do
  GameTestHelper.start_debriefing Game.first
end

Given(/^there is a game next Sunday$/) do
  GameTestHelper.create_game_next_sunday
end

Given(/^there is a multi-day game including next Sunday$/) do
  GameTestHelper.create_game_covering_next_sunday
end

Given(/^there is a multi-day game that started yesterday and includes next Sunday$/) do
  GameTestHelper.create_game_covering_next_sunday_starting_yesterday
end

When(/^the user publishes the brief for the game$/) do
  GamePage.new.visit_page(game_path(Game.first)).and.publish_briefs
end

When(/^the user publishes the debrief for the game$/) do
  GamePage.new.visit_page(game_path(Game.first)).and.finish_debrief
end


When(/^the user clicks on the show link$/) do
  EventCalendarPage.new.visit_page(event_calendar_path)
end

When(/^the user starts to create a game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.start_adding_new_game
end

Then(/^the default date is the next Sunday$/) do
  EventCalendarPage.new.check_new_game_date_is_next_sunday
end

Then(/^the default date is the Sunday after next$/) do
  EventCalendarPage.new.check_new_game_date_is_sunday_after_next
end

# Everything below this point is deprecated

Then(/^the user should see no name for the gm$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_gm(Game.first.gamesmasters, loggedin: false)
end

Then(/^the user should see a short user name for the gm$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_gm(Game.first.gamesmasters)
end

Then(/^the user should see a short user name for the player$/) do
  player = Game.first.players.first
  character = player.characters.first
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_player(player, character)
end

Then(/^the user should see a short user name for the monster$/) do
  monster = Game.first.monsters.first
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_monster(monster)
end

Then(/^the user should see a short user name for the non\-attendee$/) do
  non_attendee = Game.first.non_attendees.first
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_non_attendee(non_attendee)
end

Then(/^the user should only see the game summary$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_game_visibility(Game.first, loggedin: false)
end

# Everything below this point is deprecated

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
