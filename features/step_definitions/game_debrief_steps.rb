# Actions

When(/^the GM creates a new character for the player on a debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.add_player_to_debrief(user: "Ann Other", character: nil)
end

When(/^the GM creates a new player with a new character on a debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.add_player_to_debrief(user: nil, character: nil)
end

When(/^the GM creates a new monster on a debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.add_monster_to_debrief(user: nil)
end

When(/^the GM creates a new GM on a debrief$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.add_gm_to_debrief(user: nil)
end

# Validations

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
