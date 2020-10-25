Given(/^there is a game$/) do
  GameTestHelper.create_game
end

Given(/^there is another game$/) do
  GameTestHelper.create_game(title: "Second game")
end

Given(/^there is a game in the future$/) do
  GameTestHelper.create_game_next_sunday
end

Given(/^there is an attendance only game in the future$/) do
  GameTestHelper.create_game(start_date: 1.week.from_now, attendance_only: true)
end

Given(/^there is a game one week ago$/) do
  GameTestHelper.create_game(start_date: 1.week.ago, title: "One week ago")
end

Given(/^there is a game in the past$/) do
  if Date.today > Date.new(2018,1,7)
    GameTestHelper.create_game(start_date: 1.year.ago)
  else
    GameTestHelper.create_game(start_date: Date.new(2017,1,10))
  end
end

Given(/^the game is open$/) do
  GameTestHelper.set_open(Game.first, true)
end

Given(/^the game is not open$/) do
  GameTestHelper.set_open(Game.first, false)
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
  reset_mailer
  GameTestHelper.add_player user, character, to: Game.first
end

Given(/^there is a monster for the game$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Manfred Monster", email: "monster@mail.com", username: "monster")
  reset_mailer
  GameTestHelper.add_monster user, to: Game.first
end

Given(/^there is a non-attendee for the game$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Nick Albright", email: "na@mail.com", username: "not")
  reset_mailer
  GameTestHelper.add_non_attendee user, to: Game.first
end

Given(/^there is an attendee for the game$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Alan The Terrible", email: "att@mail.com", username: "att")
  reset_mailer
  GameTestHelper.add_attendee user, to: Game.first
end

Given(/^the character was(?:| played) on the game$/) do
  character = Character.first
  GameTestHelper.add_player character.user, character, to: Game.first
end

Given(/^the user's character is present on the game$/) do
  GameTestHelper.add_player User.first, Character.first, to: Game.first
end

Given(/^the user's character is present on the other game$/) do
  GameTestHelper.add_player User.first, Character.first, to: Game.all.second
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

When(/^the user signs up to play the game as the character$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.request_to_play(game: Game.first, as: Character.first)
end

When(/^the user signs up to monster the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.request_to_monster(game: Game.first)
end

When(/^the user marks themselves as attending the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.set_attending(game: Game.first)
end

When(/^the user marks themselves as not attending the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.set_not_attending(game: Game.first)
end

When(/^the user marks themselves as attending the attendance-only game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.set_attending(game: Game.first)
end

When(/^the user marks themselves as not attending the attendance-only game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.set_not_attending(game: Game.first)
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

Then(/^the user should not be able to sign up to play the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_cannot_sign_up_to_game(Game.first)
end

Then(/^the user should not be able to sign up to monster the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_cannot_sign_up_to_game(Game.first)
end

Then(/^the user should not be able to sign up as attending the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_cannot_sign_up_to_game(Game.first)
end

Then(/^the user should not be able to mark themselves as attending the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_cannot_sign_up_to_attend_game(Game.first)
end

Then(/^the user should not be able to mark themselves as not attending the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_cannot_sign_up_to_game(Game.first)
end

Then(/^the user should not be able to mark themselves as not attending the attendance\-only game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_cannot_sign_up_to_game(Game.first)
end

Then(/^the user should not be able to sign up as attending the attendance\-only game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_cannot_sign_up_to_game(Game.first)
end

Then(/^the user should not be able to sign up to play the attendance\-only game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_cannot_sign_up_to_play_game(Game.first)
end

Then(/^the user should not be able to sign up to monster the attendance\-only game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_cannot_sign_up_to_monster_game(Game.first)
end

Then(/^the user should appear as requesting to play the game as the character$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_character_request(Game.first, Character.first)
end

Then(/^the user should appear as requesting to monster the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_monster_request(Game.first, User.first)
end

Then(/^the user should appear as attending the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_attending(Game.first, User.first)
end

Then(/^the user should appear as not attending the game$/) do
  EventCalendarPage.new.visit_page(event_calendar_path).and.check_for_not_attending(Game.first, User.first)
end

Then("the other user should be in the list of available GMs") do
  EventCalendarPage.new.check_new_game_gms_include(User.second)
end

Then("the web-only user should not be in the list of available GMs") do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end

Then("the suspended user should not be in the list of available GMs") do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end

Then("the unapproved user should not be in the list of available GMs") do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end

Then("the unconfirmed user shoud not be in the list of available GMs") do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end

Then("the deleted user shoud not be in the list of available GMs") do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end