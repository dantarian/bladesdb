Given(/^the user has (\d+) monster points available$/) do |points|
  UserTestHelper.add_monster_point_declaration(User.first, points.to_i)
end

Given(/^the user has monster points available$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 10)
end

Given(/^the user has a monster point declaration one week ago$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 10, 1.week.ago)
end

When(/^the user (?:buys|tries to buy) (-?\d+) character points for the character$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points.to_i)
end

When(/^the user (?:buys|tries to buy) (\d+) character points for the character before the game$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points.to_i, on_date: Game.first.start_date - 1.day)
end

When(/^the user tries to buy character points for the character before the first game$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(Game.first.start_date)
end

When(/^the user tries to spend monster points on the character before their monster point declaration$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(User.first.monster_point_declaration.declared_on - 1.day)
end

When(/^the user tries to spend monster points on the character before the character was declared$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(Character.first.declared_on - 1.day)
end

When(/^the user tries to spend monster points on the character on a date in the future$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(Date.tomorrow)
end

Then(/^the user should have (\d+) monster points$/) do |points|
  CharacterPage.new.check_monster_points(points)
end

Then(/^the user should be told they cannot spend more than (\d+) monster points?$/) do |points|
  CharacterPage.new.check_for_not_enough_monster_points_available_message(points)
end

Then(/^the user should be told they cannot buy more than (\d+) character points?$/) do |points|
  CharacterPage.new.check_for_too_many_points_bought_message(points)
end

Then(/^the user should be told they cannot buy zero character points$/) do
  CharacterPage.new.check_for_cannot_buy_less_than_one_point_message
end

Then(/^the user should be told they cannot buy negative character points$/) do
  CharacterPage.new.check_for_cannot_buy_less_than_one_point_message
end

Then(/^the user should be told they cannot create a monster point spend before their last monster point spend$/) do
  CharacterPage.new.check_for_cannot_spend_before_last_spend_message(MonsterPointSpends.first.spent_on)
end

Then(/^the user should be told they cannot create a monster point spend before their penultimate game$/) do
  CharacterPage.new.check_for_cannot_spend_before_penultimate_game_message(Game.first.start_date)
end

Then(/^the user should be told they cannot create a monster point spend before their monster point declaration$/) do
  CharacterPage.new.check_for_not_before_monster_point_declaration_message(User.first.monster_point_declaration.declared_on)
end

Then(/^the user should be told they cannot create a monster point spend before the character was declared$/) do
  CharacterPage.new.check_for_not_before_character_declaration_message(Character.first.declared_on)
end

Then(/^the user should be told they cannot create a monster point spend in the future$/) do
  CharacterPage.new.check_for_cannot_spend_in_future_message
end
