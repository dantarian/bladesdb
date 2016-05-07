# Set-ups

Given(/^the GM has set their medical details$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Gerald Mann")
  UserTestHelper.fill_in_all_details(user, contact_name: "Contact GM", contact_number: "11111", medical_notes: "GM medical notes", food_notes: "GM food notes")
end

Given(/^the GM has not set their medical details$/) do
  # Do nothing.
end

Given(/^the player has set their medical details$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Poppy Player")
  UserTestHelper.fill_in_all_details(user, contact_name: "Contact Player", contact_number: "22222", medical_notes: "Player medical notes", food_notes: "Player food notes")
end

Given(/^the monster has set their medical details$/) do
  user = UserTestHelper.create_or_find_another_user(name: "Manfred Monster")
  UserTestHelper.fill_in_all_details(user, contact_name: "Contact Monster", contact_number: "33333", medical_notes: "Monster medical notes", food_notes: "Monster food notes")
end

# Actions

When(/^the user clicks on the first aid report link on the game$/) do
  GamePage.new.visit_page(game_path(Game.first)).and.open_first_aid_report
end

# Validations

Then(/^the first aid report should be displayed in a new tab$/) do
  page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
  page.find("h1").should have_text("First Aid Report for New Game")
end

Then(/^the medical details of the GM should be present$/) do
  FirstAidReportPage.new.check_medical_details(User.all.second)
end

Then(/^the medical details of the player should be present$/) do
  FirstAidReportPage.new.check_medical_details(User.all.third, role: "player")
end

Then(/^the medical details of the monster should be present$/) do
  FirstAidReportPage.new.check_medical_details(User.all.fourth, role: "monster")
end

Then(/^the medical details of the first aider should not be present$/) do
  FirstAidReportPage.new.check_no_user(User.first)
end

Then(/^the medical details of the GM should be out of date$/) do
  FirstAidReportPage.new.check_medical_details(User.all.second, updated: false)
end
