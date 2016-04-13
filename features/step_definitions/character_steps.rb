Given(/^the other user has an active character$/) do
  CharacterTestHelper.create_character(User.all.second)
  CharacterTestHelper.approve_character(User.all.second)
end

Given(/^the character is a player on the game$/) do
  game_attendance = GameAttendance.new(game_id: @game.id, user_id: @character.user_id, character_id: @character.id, attend_state: GameAttendance::PLAYING, confirm_state: GameAttendance::REQUESTED)
  game_attendance.save
end


Then(/^the user should see a short user name and character link on the character$/) do
  CharactersPage.new.check_for_character(User.all.second, Character.first)
end