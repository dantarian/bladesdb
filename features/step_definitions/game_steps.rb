Given(/^there is a game$/) do
  GameTestHelper.create_game
end

Given(/^there is another game$/) do
  GameTestHelper.create_game(title: "Second game")
end

Given(/^there is a game one week ago$/) do
  GameTestHelper.create_game(start_date: 1.week.ago)
end

Given(/^there is a game in the past$/) do
  if Date.today > new Date(2018,1,7)
    GameTestHelper.create_game(start_date: 1.year.ago)
  else
    GameTestHelper.create_game(start_date: new Date(2018,1,10))
  end
end

Given(/^the user is a GM for the game$/) do
  GameTestHelper.add_gamesmaster User.first, to: Game.first
end

Given(/^the user is a player of the game$/) do
  user = UserTestHelper.create_or_find_user
  character = CharacterTestHelper.create_character(user)
  CharacterTestHelper.approve_character(user)
  GameTestHelper.add_player user, character, to: Game.first
end

Given(/^the user is a monster of the game$/) do
  user = UserTestHelper.create_or_find_user
  GameTestHelper.add_monster user, to: Game.first
end

Given(/^the other user is a player of the game$/) do
  user = UserTestHelper.create_or_find_another_user
  character = CharacterTestHelper.create_character(user)
  CharacterTestHelper.approve_character(user)
  GameTestHelper.add_player user, character, to: Game.first
end

Given(/the other user has been created for the game$/) do
  user = User.all.second
  character = user.characters.first
  GameTestHelper.add_player user, character, to: Game.first
end

Given(/^there is a GM for the game$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Gerald Mann", email: "gm@mail.com", username: "gm1")
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  reset_mailer
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

Given(/^the character was(?:| played) on the game$/) do
  character = Character.first
  GameTestHelper.add_player character.user, character, to: Game.first
end

Given(/^the game is in the future$/) do
  GameTestHelper.set_date Date.today + 7.days, of: Game.first
end

Given(/^the game is in the past$/) do
  GameTestHelper.set_date Date.today - 7.days, of: Game.first
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

Given(/^the character has been played on a debriefed game and earned (\d+) character points$/) do |points|
  GameTestHelper.create_debriefed_game_for_first_character(points)
end

Given(/^the character has been played on another debriefed game and earned (\d+) character points$/) do |points|
  GameTestHelper.create_another_debriefed_game_for_first_character(points)
end

Given(/^the user has monstered a debriefed game and earned (\d+) monster points$/) do |points|
  GameTestHelper.create_debriefed_game_for_first_user_as_monster(points)
end

Given(/^the user has a game application$/) do
  GameTestHelper.make_application(User.first, details: "First!", to: Game.first)
end

Given(/^the other user has a game application$/) do
  GameTestHelper.make_application(User.all.second, details: "Second!", to: Game.first)
end

Given(/^the game has a maximum rank of (\d+)$/) do |rank|
  GameTestHelper.set_max_rank(of: Game.first, to: rank.to_i)
end

Given(/^the game is a non-stats game$/) do
  GameTestHelper.set_non_stats(Game.first)
end

Given(/^there is a game before the monster spend cut-off$/) do
  GameTestHelper.create_game(start_date: '2016-12-25')
end

Given(/^there is a game after the monster spend cut\-off$/) do
  GameTestHelper.create_game(start_date: '2017-01-20')
end

Given(/^the user's character is present on the game$/) do
  GameTestHelper.add_player User.first, Character.first, to: Game.first
end

Given(/^the user's character is present on the other game$/) do
  GameTestHelper.add_player User.first, Character.first, to: Game.last
end

# Actions

When(/^the user publishes the brief for the game$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.publish_briefs
end

When(/^the user clicks on the show link$/) do
  EventCalendarPage.new.visit_page(event_calendar_path)
end

When(/^the user starts to create a game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.start_adding_new_game
end



# Validations

Then(/^the default date is the next Sunday$/) do
  EventCalendarPage.new.check_new_game_date_is_next_sunday
end

Then(/^the default date is the Sunday after next$/) do
  EventCalendarPage.new.check_new_game_date_is_sunday_after_next
end

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
