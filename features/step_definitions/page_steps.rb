Given(/^a restricted page$/) do
  @page = Page.create(title: "Restricted Page", content: "Hello World!", show_to_non_users: false)
end

Given(/^I go to the home page$/) do
  visit root_path
end

Given(/^I go to my profile page$/) do
  visit user_profile_path
end

Given(/^I go to their profile page$/) do
  visit user_path(@other_user)
end

Given(/^I go to the Event Calendar/) do
  visit event_calendar_path
end

Given(/^I go to the Next Game page/) do
  visit next_game_path
end

Given(/^I go to the game page/) do
  visit game_path(@game)
end

When(/^I go to the registration page$/) do
  visit new_user_registration_path
end

Then(/^I go to the Change Password page$/) do
  visit edit_user_registration_path
end

When(/^I go to the page$/) do
  visit page_path(@page)
end

Then(/^the home page is displayed$/) do
  current_path.should == root_path
end

Then(/^the login page is displayed$/) do
  current_path.should == new_user_session_path
end

Then(/^the merge users page is displayed$/) do
  current_path.should == merge_select_users_users_path
end

Then(/^I am on the "(.*?)" profile page for "(.*?)"$/) do |actor, name|
  if actor == "User"
    page.find("h1").should have_content("Profile")
  elsif actor == "Character"
    page.find("h1").should have_content("Character Sheet")
  else
    # Do nothing - this is for games. 
  end
  page.find("li#name").find("div.fieldcontents").should have_content(name)
end

Then(/^I go to the First Aid Report for the game$/) do
  page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
  page.find("h1").should have_content("First Aid Report")
  page.find("h1").should have_content(@game.title)
end