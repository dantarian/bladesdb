# Set-ups

Given(/^the user has a monster point adjustment$/) do
  UserTestHelper.add_monster_point_adjustment(User.first, 20)
end

Given(/^the other user has a monster point adjustment$/) do
  UserTestHelper.add_monster_point_adjustment(User.all.second, 15, nil, User.first)
end

Given(/^the user has a pending monster point adjustment$/) do
  UserTestHelper.add_monster_point_adjustment(User.first, 20, approved: nil)
end

Given(/^the user has a rejected monster point adjustment$/) do
  UserTestHelper.add_monster_point_adjustment(User.first, 20, approved: false)
end

# Actions

When(/^the user requests a positive monster point adjustment$/) do
  MonsterPointsPage.new.visit_page(monster_points_path).and.request_adjustment(Date.today, 20, "Test.")
end

When(/^the user requests a negative monster point adjustment$/) do
  MonsterPointsPage.new.visit_page(monster_points_path).and.request_adjustment(Date.today, -20, "Test.")
end

When(/^the user attempts to request a monster point adjustment in the future$/) do
  MonsterPointsPage.new.visit_page(monster_points_path).and.request_adjustment(Date.today + 1.day, 20, "Test.")
end

When(/^the user attempts to create another monster point adjustment$/) do
  MonsterPointsPage.new.visit_page(monster_points_path)
end

# Validations

Then(/^a pending positive monster point adjustment should be created$/) do
  MonsterPointsPage.new.check_for_adjustment(20, state: "provisional")
end

Then(/^the user should have a pending monster point adjustment for (\d+) monster points$/) do |points|
  MonsterPointsPage.new.visit_page(monster_points_path).and.check_for_adjustment(points, state: "provisional")
end


Then(/^a pending negative monster point adjustment should be created$/) do
  MonsterPointsPage.new.check_for_adjustment(-20, state: "provisional")
end

Then(/^the user's monster points should include the monster point adjustment$/) do
  MonsterPointsPage.new.check_for_monster_points(20)
end

Then(/^the user's monster points should not include the monster point adjustment$/) do
  MonsterPointsPage.new.check_for_monster_points(0)
end

Then(/^the user should not be allowed to create another monster point adjustment$/) do
  MonsterPointsPage.new.check_for_links(text: "Request Monster Point Adjustment", display: false)
end