# Setup steps

Given(/^the character has received (\d+) character points in the debrief$/) do |points|
  GameTestHelper.add_character_to_debrief(Game.first, Character.first, points: points.to_i)
end

Given(/^the game has not been debriefed$/) do
    # No action needed
end

Given(/^the game debrief has been started$/) do
  GameTestHelper.start_debriefing Game.first
end

Given(/^the game has been debriefed$/) do
  GameTestHelper.start_debriefing Game.first
  GameTestHelper.close_debrief Game.first
end

Given(/^the other game has been debriefed$/) do
  GameTestHelper.start_debriefing Game.last
  GameTestHelper.close_debrief Game.last
end

# Action steps

When(/^the user publishes the debrief for the game$/) do
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.finish_debrief
end

When(/^the GM reopens the debrief for the game$/) do
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.reopen_debrief
end

When(/^the GM closes the debrief for the game$/) do
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.finish_debrief
end

When(/^the GM changes the character's debrief to give them (\d+) bonus points?$/) do |points|
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.update_player_debrief(Game.first, Character.first, bonus: points)
end

When(/^the GM changes the character's debrief to give them -(\d+) bonus points?$/) do |points|
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.update_player_debrief(Game.first, Character.first, bonus: "-#{points}")
end

When(/^the GM creates a new character for the player on the debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.add_player_to_debrief(player: "Ann Other", character: nil)
end

When(/^the GM creates a new player with a new character on the debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.add_player_to_debrief(player: nil, character: nil)
end

When(/^the GM creates a new monster on the debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.add_monster_to_debrief(monster: nil)
end

When(/^the GM creates a new GM on the debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.add_gm_to_debrief(gm: nil)
end

When(/^the GM gives the character a bonus point$/) do
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.update_player_debrief(Game.first, Character.first, bonus: 1)
end

# Verification steps

Then(/^the created character should appear in the debrief for the player$/) do
  DebriefPage.new.check_for_player(Game.first, User.all.second, Character.first)
end

Then(/^the created character should appear in the debrief for the created player$/) do
  DebriefPage.new.check_for_player(Game.first, User.all.second, Character.first)
end

Then(/^the character should appear in the undeclared characters list linked to the player$/) do
  CharactersPage.new.visit_page(characters_path).and.check_for_undeclared_character(User.all.second, Character.first)
end

Then(/^the character should appear in the undeclared characters list linked to the undeclared player$/) do
  CharactersPage.new.visit_page(characters_path).and.check_for_undeclared_character(User.all.second, Character.first)
end

Then(/^the player should appear in the GM\-created members list$/) do
  MembersPage.new.visit_page(users_path).and.check_for_undeclared_user(User.all.second)
end

Then(/^the created monster should appear in the debrief$/) do
  DebriefPage.new.check_for_monster(Game.first, User.all.second)
end

Then(/^the monster should appear in the GM\-created members list$/) do
  MembersPage.new.visit_page(users_path).and.check_for_undeclared_user(User.all.second)
end

Then(/^the created GM should appear in the debrief$/) do
  DebriefPage.new.check_for_gm(Game.first, User.all.second)
end

Then(/^the GM should appear in the GM\-created members list$/) do
  MembersPage.new.visit_page(users_path).and.check_for_undeclared_user(User.all.second)
end

Then(/^the debrief should be closed successfully$/) do
  DebriefPage.new.visit_page(game_path(Game.first.id)).and.check_for_closed_debrief
end
