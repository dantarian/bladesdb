Given(/^there is an unregistered user$/) do
  # Nothing to do.
end

Given(/^there is an unconfirmed user$/) do
  user = UserTestHelper.create_or_find_user(name: "Uncle Unconfirmed", email: "unconfirmed@mail.com", username: "unconfirmeduser")
end

Given(/^there is an unapproved user$/) do
  user = UserTestHelper.create_or_find_user(name: "Aunt Unapproved", email: "unapproved@mail.com", username: "unapproveduser")
  UserTestHelper.confirm(user)
end

When(/^the user attempts to register$/) do
   RegistrationPage.new.visit_page(new_user_registration_path).and.register_as("normaluser", "Norman", "norman@mail.com", "Passw0rd")
end

When(/^the user attempts to register without confirming their age is over (\d+)$/) do |arg1|
  RegistrationPage.new.visit_page(new_user_registration_path).and.register_as("normaluser", "Norman", "norman@mail.com", "Passw0rd", over18: false)
end

When(/^the user clicks the first link in the confirmation email$/) do
  open_email(User.first.email)
  click_first_link_in_email
end

Then(/^the user should see a message to check their email$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.registrations.signed_up_but_unconfirmed")
end

Then(/^the user should see a message telling them they must be at least (\d+)$/) do |arg1|
  RegistrationPage.new.check_error_message I18n.t("activerecord.errors.models.user.attributes.over18.accepted")
end

Then(/^the user should see a restricted access message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.failure.unauthenticated")
end

Then(/^the user should see an unconfirmed message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.failure.unconfirmed")
end

Then(/^the user should see a confirmation message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.confirmations.confirmed")
end

Then(/^the user should see an unapproved message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.sessions.signed_in_unapproved")
end

Then(/^the user should see a successful sign-in message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.sessions.signed_in")
end

Then(/^the user should receive a confirmation email$/) do
  EmailTestHelper.count_emails_with_subject(User.first.email, I18n.t("devise.mailer.confirmation_instructions.subject")).should == 1
end
