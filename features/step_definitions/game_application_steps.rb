Given(/^there are no applications for the game$/) do
  GameTestHelper.clear_applications(from: Game.last)
end

Given(/^the other user has an application for the game$/) do
  GameTestHelper.make_application(UserTestHelper.create_or_find_another_user, to: Game.last)
end

Given(/^the other user has been awarded the game$/) do
  GameTestHelper.add_gamesmaster(UserTestHelper.create_or_find_another_user, to: Game.last)
end

Given(/^the user has applied for the game$/) do
  GameTestHelper.make_application(UserTestHelper.create_or_find_user, to: Game.last)
end

When(/^the user applies for the game$/) do
  GamePage.new.visit_page(game_path(Game.last.id)).and.apply_for_game
end

When(/^the user edits their application for the game$/) do
  GamePage.new.visit_page(game_path(Game.last.id)).and.edit_game_application
end

When(/^the user withdraws their application for the game$/) do
  GamePage.new.visit_page(game_path(Game.last.id)).and.withdraw_game_application
end

Then(/^the game should have an application for the user$/) do
  LoginPage.new.log_out.visit_page(new_user_session_path).and.login_as(UserTestHelper.create_or_find_admin_user)
  GamePage.new.visit_page(game_path(Game.last.id)).and.check_for_application(from: User.first)
end

Then(/^the game should have a modified application for the user$/) do
  LoginPage.new.log_out.visit_page(new_user_session_path).and.login_as(UserTestHelper.create_or_find_admin_user)
  GamePage.new.visit_page(game_path(Game.last.id)).and.check_for_application(from: User.first, containing_text: "modified")
end

Then(/^the game should not have an application for the user$/) do
  LoginPage.new.log_out.visit_page(new_user_session_path).and.login_as(UserTestHelper.create_or_find_admin_user)
  GamePage.new.visit_page(game_path(Game.last.id)).and.check_no_application(from: User.first)
end

Then(/^the user should not be able to apply for the game$/) do
  GamePage.new.visit_page(game_path(Game.last.id)).and.check_no_apply_for_game_link
end
