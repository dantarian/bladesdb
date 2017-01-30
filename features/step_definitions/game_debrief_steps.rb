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
  # GameTestHelper.set_date Date.today - 7.days, of: Game.first
  GameTestHelper.start_debriefing Game.first
  GameTestHelper.close_debrief Game.first
end

Given(/^the other game has been debriefed$/) do
  # GameTestHelper.set_date Date.today - 7.days, of: Game.all.second
  GameTestHelper.start_debriefing Game.all.second
  GameTestHelper.close_debrief Game.all.second
end

# Action steps

When(/^the user publishes the brief for the game$/) do
  GamePage.new.visit_page(game_path(Game.first)).and.publish_briefs
end

When(/^the user publishes the debrief for the game$/) do
  GamePage.new.visit_page(game_path(Game.first)).and.finish_debrief
end

When(/^the GM reopens the debrief for the game$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.reopen_debrief
end

When(/^the GM closes the debrief for the game$/) do
  GamePage.new.visit_page(game_path(Game.first.id)).and.finish_debrief
end

When(/^the GM changes the character's debrief to give them (\d+) bonus points?$/) do |points|
  GamePage.new.visit_page(game_path(Game.first.id)).and.update_player_debrief(Character.first, bonus: points)
end

When(/^the GM changes the character's debrief to give them -(\d+) bonus points?$/) do |points|
  GamePage.new.visit_page(game_path(Game.first.id)).and.update_player_debrief(Character.first, bonus: "-#{points}")
end

When(/^the GM creates a new character for the player on a debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.add_player_to_debrief(player: "Ann Other", character: nil)
end

When(/^the GM creates a new player with a new character on a debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.add_player_to_debrief(player: nil, character: nil)
end

When(/^the GM creates a new monster on a debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.add_monster_to_debrief(monster: nil)
end

When(/^the GM creates a new GM on a debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.add_gm_to_debrief(gm: nil)
end

# Verification steps

Then(/^the created character should appear in the debrief for the player$/) do
  DebriefPage.new.check_for_player("Ann Other", "Judge Test")
end

Then(/^the created character should appear in the debrief for the created player$/) do
  DebriefPage.new.check_for_player("Lady Test", "Judge Test")
end

Then(/^the character should appear in the undeclared characters list linked to the player$/) do
  CharactersPage.new.visit_page(characters_path).and.check_for_undeclared_character("Ann Other", "Judge Test")
end

Then(/^the character should appear in the undeclared characters list linked to the undeclared player$/) do
  CharactersPage.new.visit_page(characters_path).and.check_for_undeclared_character("Lady Test", "Judge Test")
end

Then(/^the player should appear in the GM\-created members list$/) do
  MembersPage.new.visit_page(users_path).and.check_for_undeclared_user("Lady Test")
end

Then(/^the created monster should appear in the debrief$/) do
  DebriefPage.new.check_for_monster("Lady Test")
end

Then(/^the monster should appear in the GM\-created members list$/) do
  MembersPage.new.visit_page(users_path).and.check_for_undeclared_user("Lady Test")
end

Then(/^the created GM should appear in the debrief$/) do
  DebriefPage.new.check_for_gm("Lady Test")
end

Then(/^the GM should appear in the GM\-created members list$/) do
  MembersPage.new.visit_page(users_path).and.check_for_undeclared_user("Lady Test")
end
