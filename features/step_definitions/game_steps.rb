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

Given(/^the user is not a GM for the game$/) do
  GameTestHelper.remove_gamesmaster(User.first)
end

Given(/^the game is starting later today$/) do
  GameTestHelper.make_game_start_later_today(Game.first)
end

Given(/^the other user has signed up to the game as the character$/) do
  GameTestHelper.add_player(User.last, Character.last, to: Game.first)
end

Given(/^the character has been rejected$/) do
  GameTestHelper.reject_player(Character.last, on: Game.first)
end

Given(/^the other user has signed up to the game as a monster$/) do
  GameTestHelper.add_monster(User.last, to: Game.first)
end

Given (/^the debrief has been started for the game$/) do
  GameTestHelper.start_debriefing(Game.last)
end

Given(/^the other user is included in the debrief as a GM$/) do
  GameTestHelper.add_gm_to_debrief(Game.last, User.last)
end

# Actions

When(/^the user views the game$/) do
  GamePage.new.visit_page(game_path(Game.first.id))
end

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

When(/^the user attempts to start the debrief without supplying base points for the players$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.start_debrief(player_base: "")
end

When(/^the user attempts to start the debrief without supplying base pay for the players$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.start_debrief(danger_pay: "")
end

When(/^the user attempts to start the debrief without supplying base points for the monsters$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.start_debrief(monster_base: "")
end

When(/^the user starts the debrief$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.start_debrief
end

When(/^the user adds the other user to the debrief as a GM$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.add_gm_to_debrief(User.last)
end

When(/^the user removes the other user from the debrief as a GM$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.remove_gm_from_debrief(User.last)
end

When(/^the user attempts to set their base points higher than monster base$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.set_gm_base_points(User.first, 10)
end

When(/^the user attempts to allocate themselves more GM points than are available$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.set_gm_points(User.first, 10).and.close_debrief
end

When(/^the user attempts to allocate more GM points than are available across all gms$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.set_gm_points(User.first, 3).and.set_gm_points(User.last, 3).and.close_debrief
end

When(/^the user attempts to add themselves to the debrief as a monster$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.attempt_to_add_monster_to_debrief
end

When(/^the user adds themselves to the debrief as having played the character$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.add_player_to_debrief(User.last, Character.last)
end

When(/^the user closes the debrief$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.close_debrief
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

Then(/^the user should be able to start the debrief for the game$/) do
  GamePage.new.check_can_start_debrief
end

Then(/^the user should not be able to start the debrief for the game$/) do
  GamePage.new.check_cannot_start_debrief
end

Then(/^the user should be told they must supply base player points$/) do
  GamePage.new.check_asked_for_player_points
end

Then(/^the user should be told they must supply base player pay$/) do
  GamePage.new.check_asked_for_player_pay
end

Then(/^the user should be told they must supply base monster points$/) do
  GamePage.new.check_asked_for_monster_points
end

Then(/^the character should be included in the debrief$/) do
  GamePage.new.check_character_is_in_debrief(Character.last)
end

Then(/^the character should not be included in the debrief$/) do
  GamePage.new.check_character_is_not_in_debrief(Character.last)
end

Then(/^the user should be included in the debrief as a GM$/) do
  GamePage.new.check_user_is_in_debrief_as_gm(User.first)
end

Then(/^the user should not be included in the debrief as a monster$/) do
  GamePage.new.check_user_is_not_in_debrief_as_monster(User.first)
end

Then(/^the other user should be included in the debrief as a monster$/) do
  GamePage.new.check_user_is_in_debrief_as_monster(User.last)
end

Then(/^the other user should be included in the debrief as a GM$/) do
  GamePage.new.check_user_is_in_debrief_as_gm(User.last)
end

Then(/^the other user should not be included in the debrief as a GM$/) do
  GamePage.new.check_user_is_not_in_debrief_as_gm(User.last)
end

Then(/^the GM should start with (\d+) points$/) do |points|
  GamePage.new.check_gm_has_base_points(User.first, points)
  GamePage.new.check_gm_has_gm_points(User.first, 0)
end

Then(/^there should be (\d+) GM points to share between GMs$/) do |points|
  GamePage.new.check_remaining_gm_points(points)
end

Then(/^the user should be told that GM base points cannot be higher than monster base$/) do
  GamePage.new.check_error_message("Base points must be less than or equal to monster base for the game")
end

Then(/^the user should be told they cannot allocate more GM points than are available$/) do
  GamePage.new.check_error_message("Cannot finish debrief: Too many GM points allocated.")
end

Then(/^the user should not be in the list of users$/) do
  GamePage.new.check_user_is_not_in_list_of_users_who_can_be_added_to_the_debrief(User.last)
end

Then(/^the other user should be in the list of available GMs$/) do
  EventCalendarPage.new.check_new_game_gms_include(User.second)
end

Then(/^the web-only user should not be in the list of available GMs$/) do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end

Then(/^the suspended user should not be in the list of available GMs$/) do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end

Then(/^the unapproved user should not be in the list of available GMs$/) do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end

Then(/^the unconfirmed user shoud not be in the list of available GMs$/) do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end

Then(/^the deleted user shoud not be in the list of available GMs$/) do
  EventCalendarPage.new.check_new_game_gms_do_not_include(User.second)
end
