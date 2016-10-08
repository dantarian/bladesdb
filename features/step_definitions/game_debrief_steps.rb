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
  GameTestHelper.set_date Date.today - 7.days, of: Game.first
  GameTestHelper.start_debriefing Game.first
  GameTestHelper.close_debrief Game.first
end

Given(/^the other game has been debriefed$/) do
  GameTestHelper.set_date Date.today - 7.days, of: Game.all.second
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

When(/^the GM changes the character's debrief to give them (\d+) points$/) do |points|
  GamePage.new.visit_page(game_path(Game.first.id)).and.update_player_debrief(Character.first, total_cp: points)
end

# Verification steps

