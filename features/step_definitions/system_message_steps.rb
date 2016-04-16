Then(/^the user should see a login access message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.failure.unauthenticated")
end

Then(/^the user should see an unauthorised access message$/) do
  HomePage.new.check_is_displaying_message I18n.t("failure.permission_denied")
end

Then(/^the user should see an already signed in message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.failure.already_authenticated")
end

Then(/^the user should see a suspended account message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.failure.user.suspended")
end

Then(/^the user should see an inactive account message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.failure.inactive")
end

Then(/^the user should see a successful login message$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.sessions.signed_in")
end

Then(/^a profile updated message should be displayed$/) do
  ProfilePage.new.check_is_displaying_message I18n.t("user.success.own_profile_updated")
end

Then(/^an other user\'s profile updated message should be displayed$/) do
  ProfilePage.new.check_is_displaying_message I18n.t("user.success.other_profile_updated", name: User.all.second.name)
end

Then(/^a name already in use message should be displayed$/) do
  profile = ProfilePage.new
  profile.check_is_displaying_message I18n.t("user.validation.dialog_header")
  profile.check_is_displaying_message I18n.t("user.validation.dialog_main")
  profile.check_is_displaying_message I18n.t("user.validation.name_uniqueness")
end

Then(/^a login already in use message should be displayed$/) do
  profile = ProfilePage.new
  profile.check_is_displaying_message I18n.t("user.validation.dialog_header")
  profile.check_is_displaying_message I18n.t("user.validation.dialog_main")
  profile.check_is_displaying_message I18n.t("user.validation.username_uniqueness")
end

Then(/^an email already in use message should be displayed$/) do
  profile = ProfilePage.new
  profile.check_is_displaying_message I18n.t("user.validation.dialog_header")
  profile.check_is_displaying_message I18n.t("user.validation.dialog_main")
  profile.check_is_displaying_message I18n.t("user.validation.email_uniqueness")
end

Then(/^a successful password change message should be displayed$/) do
  ProfilePage.new.check_is_displaying_message I18n.t("devise.registrations.updated")
end

Then(/^a password mismatch message should be displayed$/) do
  RegistrationUpdatePage.new.check_is_displaying_message "doesn\'t match"
end

Then(/^an activation email message should be displayed$/) do
  MembersPage.new.check_is_displaying_message I18n.t("user.success.email_resent")
end

Then(/^a roles updated message should be displayed$/) do
  MembersPage.new.check_is_displaying_message I18n.t("user.success.roles_updated")
end