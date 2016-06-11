# Set-ups

Given(/^the user has a monster point declaration$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 20)
end

Given(/^the other user has a monster point declaration$/) do
  UserTestHelper.add_monster_point_declaration(User.all.second, 15, nil, User.first)
end

Given(/^the user has a pending monster point declaration$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 20, approved: nil)
end

Given(/^the user has a rejected monster point declaration$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 20, approved: false)
end

# Actions

When(/^the user declares their starting monster points$/) do
  MonsterPointsPage.new.visit_page(monster_points_path).and.declare_monster_points(Date.today, 20)
end

When(/^the user attempts to declare a negative starting number of monster points$/) do
  MonsterPointsPage.new.visit_page(monster_points_path).and.declare_monster_points(Date.today, -20)
end

When(/^the user attempts to declare a starting number of monster points in the future$/) do
  MonsterPointsPage.new.visit_page(monster_points_path).and.declare_monster_points(Date.today + 1.day, 20)
end

When(/^the user edits their monster point declaration$/) do
  MonsterPointsPage.new.visit_page(monster_points_path).and.edit_declaration(Date.today, 15)
end

When(/^the user attempts to create another monster point declaration$/) do
  MonsterPointsPage.new.visit_page(monster_points_path)
end

When(/^the user attempts to edit their monster point declaration$/) do
  MonsterPointsPage.new.visit_page(monster_points_path)
end

# Validations

Then(/^a pending monster point declaration should be created$/) do
  MonsterPointsPage.new.check_for_declaration(20, state: "provisional")
end

Then(/^the user's base monster points should be set from the monster point declaration$/) do
  MonsterPointsPage.new.check_for_monster_points(20)
end

Then(/^the user's base monster points should not be set from the monster point declaration$/) do
  MonsterPointsPage.new.check_for_monster_points(0)
end

Then(/^the monster point declaration should show the new details$/) do
  MonsterPointsPage.new.check_for_declaration(15, state: "provisional")
end

Then(/^the user should not be allowed to edit the monster point declaration$/) do
  MonsterPointsPage.new.check_for_links(text: "Update", display: false)
end

Then(/^the user should not be allowed to create another monster point declaration$/) do
  MonsterPointsPage.new.check_for_links(text: "Declare Monster Points", display: false)
end