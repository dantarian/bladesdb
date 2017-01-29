# Page set-ups.

Given(/^there is a restricted page$/) do
  @page = PageTestHelper.create_page(show_to_non_users: false)
end

Given(/^the user is on the home page$/) do
  visit root_path
end

Given(/^the user is on their profile page$/) do
  visit user_profile_path
end

Given(/^the user is on the other user's profile page$/) do
  visit user_path(User.all.second)
end

Given(/^the user is on the event calendar/) do
  visit event_calendar_path
end

Given(/^the user is on the Next Game page/) do
  visit next_game_path
end

Given(/^the user is on the game page/) do
  visit game_path(Game.first)
end

Given(/^the user is on the members page$/) do
  visit users_path
end

Given(/^the user is on the message boards maintenance page$/) do
  visit admin_boards_path
end

# Actions

When(/^the user is on the home page$/) do
  visit root_path
end

When(/^the user goes to their profile page$/) do
  visit user_profile_path
end

When(/^the user goes to the other user's profile page$/) do
  visit user_path(User.all.second)
end

When(/^the user goes to the event calendar/) do
  visit event_calendar_path
end

When(/^the user goes to the Next Game page/) do
  visit next_game_path
end

When(/^the user goes to the game page/) do
  visit game_path(Game.first)
end

When(/^the user goes to the page$/) do
  visit page_path(Page.last)
end

When(/^the user goes to the registration page$/) do
  visit new_user_registration_path
end

When(/^the user goes to the members page$/) do
  visit users_path
end

When(/^the user goes to the message board$/) do
  visit board_path(Board.first)
end

When(/^the user goes to the characters page$/) do
  visit characters_path
end

When(/^the user goes to their monster points page$/) do
  visit monster_points_path
end

# Validations

Then(/^the Change Password page should be displayed$/) do
  current_path.should == edit_user_registration_path
end

Then(/^the home page should be displayed$/) do
  current_path.should == root_path
end

Then(/^the login page should be displayed$/) do
  current_path.should == new_user_session_path
end

Then(/^the merge users page should be displayed$/) do
  current_path.should == merge_select_users_users_path
end

Then(/^the message board should be displayed$/) do
  current_path.should == board_path(Board.first)
end

Then(/^the user's profile should be displayed$/) do
  ProfilePage.new.check_for_name(User.first)
end

Then(/^the other user's profile should be displayed$/) do
  ProfilePage.new.check_for_name(User.all.second)
end

Then(/^the members list should be displayed$/) do
  current_path.should == users_path
end
