# Setup steps

Given(/^the user has (\d+) monster points? available$/) do |points|
  UserTestHelper.add_monster_point_declaration(User.first, points.to_i)
end

Given(/^the user has earned (\d+) monster points?$/) do |points|
  GameTestHelper.create_debriefed_game_for_first_user_as_monster(points.to_i)
end

Given(/^the user has monster points available$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 10)
end

Given(/^the user has a monster point declaration one week ago$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 10, 1.week.ago)
end

Given(/^the user has a monster point declaration since the monster point spend$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 10, MonsterPointSpend.first.spent_on + 1.day)
end

Given(/^the user has a rejected monster point declaration since the monster point spend$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 10, MonsterPointSpend.first.spent_on + 1.day, approved: false)
end

Given(/^the user has a pending monster point declaration for (\d+) monster points?$/) do |points|
  UserTestHelper.add_monster_point_declaration(User.first, points.to_i, 1.week.ago, approved: nil)
end

Given(/^the user has a rejected monster point declaration one week ago$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 10, 1.week.ago, approved: false)
end

Given(/^the user has a monster point adjustment since the monster point spend$/) do
  UserTestHelper.add_monster_point_adjustment(User.first, 10, MonsterPointSpend.first.spent_on + 1.day)
end

Given(/^the user has a pending monster point adjustment for \+(\d+) monster points$/) do |points|
  UserTestHelper.add_monster_point_adjustment(User.first, points.to_i, 1.week.ago, approved: nil)
end

Given(/^the user has a pending monster point adjustment for \-(\d+) monster points$/) do |points|
  UserTestHelper.add_monster_point_adjustment(User.first, -(points.to_i), 1.week.ago, approved: nil)
end

Given(/^there is a monster point spend on the character$/) do
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first)
end

Given(/^there is a monster point spend on the character one week ago$/) do
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: 1.week.ago)
end

Given(/^there is a monster point spend on the character before the game$/) do
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: Game.first.start_date - 1.day)
end

Given(/^there is a monster point spend on the character since the game$/) do
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: Game.first.start_date + 1.day)
end

Given(/^the user bought 1 character point for the character yesterday$/) do
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: Date.yesterday, character_points_gained: 1, monster_points_spent: 1)
end

Given(/^the user bought (\d+) character points? for (\d+) monster points? for the character yesterday$/) do |cp, mp|
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: Date.yesterday, character_points_gained: cp, monster_points_spent: mp)
end

Given(/^the user bought (\d+) character points? for the character before the game$/) do |points|
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: Game.first.start_date - 1.day, character_points_gained: points, monster_points_spent: points)
end

Given(/^the user bought (\d+) character points? for (\d+) monster points? for the character after the game$/) do |cp, mp|
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: Game.first.start_date + 1.day, character_points_gained: cp, monster_points_spent: mp)
end

Given(/^the user bought (\d+) character points? for (\d+) monster points? for the character after the character point adjustment$/) do |cp, mp|
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: CharacterPointAdjustment.first.declared_on + 1.day, character_points_gained: cp, monster_points_spent: mp)
end

Given(/^the user bought (\d+) character points? for (\d+) monster points? for the other character$/) do |cp, mp|
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.all.second, date: Date.yesterday, character_points_gained: cp, monster_points_spent: mp)
end

Given(/^the user bought (\d+) character points? for (\d+) monster points? for the other character before the game$/) do |cp, mp|
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.all.second, date: Game.first.start_date - 1.day, character_points_gained: cp, monster_points_spent: mp)
end

Given(/^the user has a rejected monster point adjustment since the monster point spend$/) do
  UserTestHelper.add_monster_point_adjustment(User.first, 1, MonsterPointSpend.first.spent_on + 1.day, approved: false)
end

Given(/^the character has a character point adjustment since the monster point spend$/) do
  CharacterTestHelper.add_character_point_adjustment(Character.first, 1, MonsterPointSpend.first.spent_on + 1.day)
end

Given(/^the user has a rejected character point adjustment since the monster point spend$/) do
  CharacterTestHelper.add_character_point_adjustment(Character.first, 1, MonsterPointSpend.first.spent_on + 1.day, approved: false)
end

Given(/^the character has a monster point spend before the cut-off that takes the character to rank 10.0$/) do
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: '2016-12-28', character_points_gained: 70, monster_points_spent: 70)
end

Given(/^the character has a monster point spend after the cut\-off that takes the character to rank 10.0$/) do
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, date: '2017-01-25', character_points_gained: 70, monster_points_spent: 70)
end

Given(/^the character has 100 monster points available two weeks before the monster spend cut\-off$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 100, '2016-12-27')
end

# Action steps

When(/^the user (?:buys|tries to buy) (-?\d+) character points? for the character$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points.to_i)
end

When(/^the user (?:buys|tries to buy) (-?\d+) character points? for the character yesterday$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points.to_i, date: Date.yesterday)
end

When(/^the user (?:buys|tries to buy) (\d+) character points? for the character before the game$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points.to_i, date: Game.first.start_date - 1.day)
end

When(/^the user (?:buys|tries to buy) (\d+) character points? for the character after the game$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points.to_i, date: Game.first.start_date + 1.day)
end

When(/^the user tries to buy character points for the character before the (?:|first )game$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(Game.first.start_date)
end

When(/^the user (?:buys|tries to buy) (\d+) character points? for the character before their monster point declaration$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points.to_i, date: User.first.monster_point_declaration.declared_on - 1.day)
end

When(/^the user tries to spend monster points on the character before their monster point declaration$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(User.first.monster_point_declaration.declared_on - 1.day)
end

When(/^the user (?:buys|tries to buy) (\d+) character points? for the character before the character point adjustment$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points, date: CharacterPointAdjustment.first.declared_on - 1.day)
end

When(/^the user (?:buys|tries to buy) (\d+) character points? for the character after the character point adjustment$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points, date: CharacterPointAdjustment.first.declared_on + 1.day)
end

When(/^the user (?:buys|tries to buy) (\d+) character points? for the character before the monster point spend on the other character$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.buy_character_points_with_monster_points(points, date: MonsterPointSpend.first.spent_on - 1.day)
end

When(/^the user tries to spend monster points on the character before the character was declared$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(Character.first.declared_on - 1.day)
end

When(/^the user tries to spend monster points on the character on a date in the future$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(Date.tomorrow)
end

When(/^the user deletes the monster point spend$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.delete_last_monster_point_spend
end

When(/^the user tries to delete the monster point spend$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_delete_last_monster_point_spend(delete_new_character_monster_point_spend_path(Character.first))
end

When(/^the user tries to spend monster points before the monster point spend$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(MonsterPointSpend.first.spent_on - 1.day)
end

When(/^the user tries to spend monster points before the character point adjustment$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(CharacterPointAdjustment.first.declared_on - 1.day)
end

When(/^the user tries to spend monster points after the character point adjustment$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.try_to_spend_monster_points_on(CharacterPointAdjustment.first.declared_on + 1.day)
end

# Verification steps

Then(/^there should be no option for spending monster points$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.confirm_absence_of_spend_monster_points_link
end

Then(/^the user should have (-?\d+) monster points$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.check_monster_points(points)
end

Then(/^the monster point spend should be deleted$/) do
  CharacterPage.new.visit_page(character_path(Character.first)).and.check_no_monster_point_spend
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
  CharacterPage.new.check_for_cannot_spend_before_last_spend_message(MonsterPointSpend.first.spent_on)
end

Then(/^the user should be told they cannot create a monster point spend before their most recent debriefed game$/) do
  CharacterPage.new.check_for_cannot_spend_before_most_recent_debriefed_game_message(Game.first.start_date)
end

Then(/^the user should be told they cannot create a monster point spend before their monster point declaration$/) do
  CharacterPage.new.check_for_cannot_spend_before_monster_point_declaration_message(User.first.monster_point_declaration.declared_on)
end

Then(/^the user should be told they cannot create a monster point spend before the character was declared$/) do
  CharacterPage.new.check_for_cannot_spend_before_character_declaration_message(Character.first.declared_on)
end

Then(/^the user should be told they cannot create a monster point spend in the future$/) do
  CharacterPage.new.check_for_cannot_spend_in_future_message
end

Then(/^the user should be told they cannot spend monster points on an unapproved character$/) do
  CharacterPage.new.check_for_cannot_spend_on_unapproved_character_message
end

Then(/^the user should be told they cannot spend monster points on a retired character$/) do
  CharacterPage.new.check_for_cannot_spend_on_retired_character_message
end

Then(/^the user should be told they cannot spend monster points on a dead character$/) do
  CharacterPage.new.check_for_cannot_spend_on_dead_character_message
end

Then(/^the user should be told they cannot spend monster points on a recycled character$/) do
  CharacterPage.new.check_for_cannot_spend_on_recycled_character_message
end

Then(/^the user should be told they cannot spend monster points on an undeclared character$/) do
  CharacterPage.new.check_for_cannot_spend_on_undeclared_character_message
end

Then(/^the user should be told they cannot delete a monster point spend before a debriefed game$/) do
  CharacterPage.new.check_for_cannot_delete_spend_before_debriefed_game_message(Game.last.start_date)
end

Then(/^the user should be told they cannot delete a monster point spend before a monster point declaration$/) do
  CharacterPage.new.check_for_cannot_delete_spend_before_monster_point_declaration(User.first.monster_point_declaration.declared_on)
end

Then(/^user should be told they cannot delete a monster point spend before a monster point adjustment$/) do
  CharacterPage.new.check_for_cannot_delete_spend_before_monster_point_adjustment(User.first.monster_point_adjustments.last.declared_on)
end

Then(/^the user should be told they cannot delete a monster point spend on a dead character$/) do
  CharacterPage.new.check_for_cannot_delete_spend_on_dead_character
end

Then(/^the user should be told they cannot delete a monster point spend on a retired character$/) do
  CharacterPage.new.check_for_cannot_delete_spend_on_retired_character
end

Then(/^the user should be told they cannot delete a monster point spend on a recycled character$/) do
  CharacterPage.new.check_for_cannot_delete_spend_on_recycled_character
end

Then(/^the user should receive an e\-mail telling them that their monster point spend has reduced in cost$/) do
  EmailTestHelper.check_for_email(to: User.first.email, regarding: I18n.t("email_subjects.mp_cost_decreased"))
end

Then(/^the user should receive an e\-mail telling them that their monster point spend has increased in cost$/) do
  EmailTestHelper.check_for_email(to: User.first.email, regarding: I18n.t("email_subjects.mp_cost_increased"))
end

Then(/^user should be told they cannot delete a monster point spend before a character point adjustment$/) do
  CharacterPage.new.check_for_cannot_delete_spend_before_character_point_adjustment(Character.first.character_point_adjustments.last.declared_on)
end

Then(/^the user should be told they cannot create a monster point spend before the character point adjustment$/) do
  CharacterPage.new.check_for_cannot_spend_before_character_point_adjustment(Character.first.character_point_adjustments.last.declared_on)
end
