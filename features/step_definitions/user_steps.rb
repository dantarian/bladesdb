# Set-up steps

Given(/^there is a user$/) do
  user = UserTestHelper.create_or_find_user
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  reset_mailer
end

Given(/^there is another user$/) do
  user = UserTestHelper.create_or_find_another_user
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  reset_mailer
end

Given(/^there is an admin user$/) do
  user = UserTestHelper.create_or_find_user(name: "Alicia Admin", email: "alicia@mail.com", username: "adminuser")
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  UserTestHelper.grant_role(user, Role.find_by(rolename: "administrator"))
  reset_mailer
end

Given(/^there is a web-only user$/) do
  user = UserTestHelper.create_or_find_user(name: "Warren Webonly", email: "warren@mail.com", username: "webonlyuser")
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  UserTestHelper.grant_role(user, Role.find_by(rolename: "webonly"))
  reset_mailer
end

Given(/^there is a first aider user$/) do
  user = UserTestHelper.create_or_find_user(name: "Francis Firstaider", email: "francis@mail.com", username: "firstaideruser")
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  UserTestHelper.grant_role(user, Role.find_by(rolename: "firstaider"))
  reset_mailer
end

Given(/^there is a committee user$/) do
  user = UserTestHelper.create_or_find_user(name: "Colin Committee", email: "colin@mail.com", username: "committeeuser")
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  UserTestHelper.grant_role(user, Role.find_by(rolename: "committee"))
  reset_mailer
end

Given(/^there is a character ref user$/) do
  user = UserTestHelper.create_or_find_user(name: "Charles Characterref", email: "charles@mail.com", username: "characterrefuser")
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  UserTestHelper.grant_role(user, Role.find_by(rolename: "characterref"))
  reset_mailer
end

Given(/^there is a suspended user$/) do
  user = UserTestHelper.create_or_find_user(name: "Susan Suspended", email: "susan@mail.com", username: "suspendeduser")
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  UserTestHelper.suspend(user)
  reset_mailer
end

Given(/^there is a deleted user$/) do
  user = UserTestHelper.create_or_find_user(name: "David Deleted", email: "david@mail.com", username: "deleteduser")
  UserTestHelper.confirm(user)
  UserTestHelper.approve(user)
  UserTestHelper.delete(user)
  reset_mailer
end

Given(/^there is a GM\-created user$/) do
  UserTestHelper.create_or_find_user(name: "Gerry GM'Created", email: "gerry@mail.com", username: "gmcreateduser", state: :passive)
end

Given(/^the user has filled in all their details$/) do
  UserTestHelper.fill_in_all_details(User.first)
end

Given(/^the other user has filled in all their details$/) do
  UserTestHelper.fill_in_all_details(User.all.second)
end

Given(/^the user is not logged in$/) do
  # Nothing to do.
end

Given(/^the user is logged in$/) do
  LoginPage.new.visit_page(new_user_session_path).and.login_with_credentials User.first.username, UserTestHelper::DEFAULT_PASSWORD
end

Given(/^the other user is a web-only user$/) do
  UserTestHelper.grant_role(User.all.second, Role.find_by(rolename: "webonly"))
end

Given(/^the GM is logged in$/) do
  LoginPage.new.visit_page(new_user_session_path).and.login_with_credentials User.all.second.username, UserTestHelper::DEFAULT_PASSWORD
end

# Action steps

When(/^the user logs in$/) do
  LoginPage.new.visit_page(new_user_session_path).and.login_with_credentials User.first.username, UserTestHelper::DEFAULT_PASSWORD
end

When(/^the other user logs in$/) do
  LoginPage.new.visit_page(new_user_session_path).and.login_with_credentials User.last.username, UserTestHelper::DEFAULT_PASSWORD
end

When(/^the GM logs in$/) do
  LoginPage.new.visit_page(new_user_session_path).and.login_with_credentials User.find_by_email("gm@mail.com").username, UserTestHelper::DEFAULT_PASSWORD
end

When(/^the (?:GM|character ref|user) logs out$/) do
  BladesDBPage.new.visit_page("/").and.log_out
end

When(/^the character ref logs in$/) do
  LoginPage.new.visit_page(new_user_session_path).and.login_with_credentials User.find_by_email("charles@mail.com").username, UserTestHelper::DEFAULT_PASSWORD
end

When(/^the user updates their name$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_name("Test McTest")
end

When(/^the user updates their name to that of the other user$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_name(User.all.second.name)
end

When(/^the user updates their login$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_login("genericlogin")
end

When(/^the user updates their login to that of the other user$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_login(User.all.second.username)
end

When(/^the user updates their email$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_email("generic@mail.com")
end

When(/^the user updates their email to that of the other user$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_email(User.all.second.email)
end

When(/^the user changes their password$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.change_password("paSS5word", "paSS5word")
end

When(/^the user changes their password incorrectly$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.change_password("paSS5word", "pi11Le")
end

When(/^the user updates their contact number$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_contact("07111 111111")
end

When(/^the user updates their emergency contact$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_emergency_contact("Test Contact", "07111 111111")
end

When(/^the user updates their medical notes$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_medical_notes("Allergy to bees.")
end

When(/^the user updates their food notes$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_food_notes("Allergy to alliums.")
end

When(/^the user updates their notes$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.update_notes("I am awesome.")
end

When(/^the user updates the other user's name$/) do
  ProfilePage.new.visit_page(user_path(User.all.second)).and.update_name("Test McTest")
end

When(/^the user updates the other user's login$/) do
  ProfilePage.new.visit_page(user_path(User.all.second)).and.update_login("genericlogin")
end

When(/^the user updates the other user's email$/) do
  ProfilePage.new.visit_page(user_path(User.all.second)).and.update_email("generic@mail.com")
end

When(/^the user updates the other user's contact number$/) do
  ProfilePage.new.visit_page(user_path(User.all.second)).and.update_contact("07111 111111")
end

When(/^the user updates the other user's emergency contact$/) do
  ProfilePage.new.visit_page(user_path(User.all.second)).and.update_emergency_contact("Test Contact", "07111 111111")
end

When(/^the user updates the other user's medical notes$/) do
  ProfilePage.new.visit_page(user_path(User.all.second)).and.update_medical_notes("Allergy to bees.")
end

When(/^the user updates the other user's food notes$/) do
  ProfilePage.new.visit_page(user_path(User.all.second)).and.update_food_notes("Allergy to alliums.")
end

When(/^the user updates the other user's notes$/) do
  ProfilePage.new.visit_page(user_path(User.all.second)).and.update_notes("I am awesome.")
end

When(/^the user clicks on their name$/) do
  MembersPage.new.click_link(User.first.name)
end

When(/^the user clicks on the other user's name$/) do
  MembersPage.new.click_link(User.all.second.name)
end

# Condition steps

Then(/^the user should be logged out$/) do
  pending
end

Then(/^the user's account should be suspended$/) do
  pending
end

Then(/^they should see all their own profile fields$/) do
  profile = ProfilePage.new.visit_page(user_path(User.first))
  profile.check_for_core_fields(User.first)
  profile.check_for_login(User.first)
  profile.check_for_contact(User.first)
  profile.check_for_medical_fields(User.first)
  profile.check_for_food(User.first)
  profile.check_for_debrief_comments
end

Then(/^they should see all profile fields$/) do
  profile = ProfilePage.new.visit_page(user_path(User.last))
  profile.check_for_core_fields(User.last)
  profile.check_for_login(User.last)
  profile.check_for_contact(User.last)
  profile.check_for_medical_fields(User.last)
  profile.check_for_food(User.last)
  profile.check_for_debrief_comments
end

Then(/^they should see core profile fields$/) do
  profile = ProfilePage.new.visit_page(user_path(User.last))
  profile.check_for_core_fields(User.last)
end

Then(/^they should see gm relevant profile fields$/) do
  profile = ProfilePage.new.visit_page(user_path(User.last))
  profile.check_for_core_fields(User.last)
  profile.check_for_medical_fields(User.last)
  profile.check_for_food(User.last)
  profile.check_for_debrief_comments
end

Then(/^they should see committee relevant profile fields$/) do
  profile = ProfilePage.new.visit_page(user_path(User.last))
  profile.check_for_core_fields(User.last)
  profile.check_for_contact(User.last)
  profile.check_for_medical_fields(User.last)
  profile.check_for_food(User.last)
  profile.check_for_debrief_comments
end

Then(/^they should see character\-ref relevant profile fields$/) do
  profile = ProfilePage.new.visit_page(user_path(User.last))
  profile.check_for_core_fields(User.last)
end

Then(/^they should see first\-aider relevant profile fields$/) do
  profile = ProfilePage.new.visit_page(user_path(User.last))
  profile.check_for_core_fields(User.last)
  profile.check_for_medical_fields(User.last)
  profile.check_for_food(User.last)
end

Then(/^they should see their own change password link$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.check_for_links(text: "Change password")
end

Then(/^they should see a change password link$/) do
  ProfilePage.new.visit_page(user_path(User.last)).and.check_for_links(text: "Change password")
end

Then(/^they should not see a change password link$/) do
  ProfilePage.new.visit_page(user_path(User.last)).and.check_for_links(text: "Change password", display: false)
end

Then(/^they should see their own profile edit links$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.check_for_links(text: "Edit")
end

Then(/^they should see the other user\'s profile edit links$/) do
  ProfilePage.new.visit_page(user_path(User.last)).and.check_for_links(text: "Edit")
end

Then(/^they should not see any profile edit links$/) do
  ProfilePage.new.visit_page(user_path(User.last)).and.check_for_links(text: "Edit", display: false)
end

Then(/^the user's P:M ratio should be displayed in the sidebar$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.check_pm_ratio(User.first)
end

Then(/^the user's statistics should be displayed$/) do
  ProfilePage.new.visit_page(user_path(User.first)).and.check_for_statistics(User.first)
end

Then(/^the new name should be displayed on their profile$/) do
  ProfilePage.new.check_for_name(User.first)
end

Then(/^the new login should be displayed on their profile$/) do
  ProfilePage.new.check_for_login(User.first)
end

Then(/^the new email should be displayed on their profile$/) do
  ProfilePage.new.check_for_email(User.first)
end

Then(/^the new contact number should be displayed on their profile$/) do
  ProfilePage.new.check_for_contact(User.first)
end

Then(/^the new emergency contact should be displayed on their profile$/) do
  ProfilePage.new.check_for_emergency_contact(User.first)
end

Then(/^the new medical notes should be displayed on their profile$/) do
  ProfilePage.new.check_for_medical_notes(User.first)
end

Then(/^the new food notes should be displayed on their profile$/) do
  ProfilePage.new.check_for_food(User.first)
end

Then(/^the new notes should be displayed on their profile$/) do
  ProfilePage.new.check_for_notes(User.first)
end

Then(/^the new name should be displayed on the other user\'s profile$/) do
  ProfilePage.new.check_for_name(User.all.second)
end

Then(/^the new login should be displayed on the other user\'s profile$/) do
  ProfilePage.new.check_for_login(User.all.second)
end

Then(/^the new email should be displayed on the other user\'s profile$/) do
  ProfilePage.new.check_for_email(User.all.second)
end

Then(/^the new contact number should be displayed on the other user\'s profile$/) do
  ProfilePage.new.check_for_contact(User.all.second)
end

Then(/^the new emergency contact should be displayed on the other user\'s profile$/) do
  ProfilePage.new.check_for_emergency_contact(User.all.second)
end

Then(/^the new medical notes should be displayed on the other user\'s profile$/) do
  ProfilePage.new.check_for_medical_notes(User.all.second)
end

Then(/^the new food notes should be displayed on the other user\'s profile$/) do
  ProfilePage.new.check_for_food(User.all.second)
end

Then(/^the new notes should be displayed on the other user\'s profile$/) do
  ProfilePage.new.check_for_notes(User.all.second)
end
