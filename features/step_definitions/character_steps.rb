Given(/^the user has a character$/) do
  CharacterTestHelper.create_character(User.first)
  CharacterTestHelper.approve_character(User.first)
end

Given(/^the other user has an active character$/) do
  CharacterTestHelper.create_character(User.all.second)
  CharacterTestHelper.approve_character(User.all.second)
end

Given(/^the other user has a character$/) do
  CharacterTestHelper.create_character(User.all.second, name: "Nigel the Magnificent")
  CharacterTestHelper.approve_character(User.all.second, Character.all.second)
end

Given(/^the character is a player on the game$/) do
  game_attendance = GameAttendance.new(game_id: @game.id, user_id: @character.user_id, character_id: @character.id, attend_state: GameAttendance::PLAYING, confirm_state: GameAttendance::REQUESTED)
  game_attendance.save
end

Given(/^the character has (\d+) character points(?: before the games?)?$/) do |points|
  CharacterTestHelper.set_starting_points(Character.first, points)
end

Given(/^the character is pending approval$/) do
  CharacterTestHelper.make_pending(Character.first)
end

Given(/^the character is retired$/) do
  CharacterTestHelper.retire_character
end

Given(/^the character is dead$/) do
  CharacterTestHelper.permdeath_character
end

Given(/^the character is recycled$/) do
  CharacterTestHelper.recycle_character
end

Given(/^the character is undeclared$/) do
  CharacterTestHelper.undeclare_character
end



Then(/^the user should see a short user name and character link on the character$/) do
  CharactersPage.new.check_for_character(User.all.second, Character.first)
end

Then(/^the character should have (\d+) character points$/) do |points|
  CharacterPage.new.visit_page(Character.first).and.check_character_points(points.to_i)
end

