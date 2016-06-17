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
  RegistrationUpdatePage.new.check_is_displaying_message I18n.t("errors.messages.confirmation", attribute: "Password")
end

Then(/^an activation email message should be displayed$/) do
  MembersPage.new.check_is_displaying_message I18n.t("user.success.email_resent")
end

Then(/^a roles updated message should be displayed$/) do
  MembersPage.new.check_is_displaying_message I18n.t("user.success.roles_updated")
end

Then(/^a monster point declaration made message should be displayed$/) do
  MonsterPointsPage.new.check_is_displaying_message I18n.t("user.monster_point_declaration.success.created")
end

Then(/^a negative monster point declaration not allowed message should be displayed$/) do
  MonsterPointsPage.new.check_is_displaying_message I18n.t("errors.messages.greater_than_or_equal_to", count: 0)
end

Then(/^a monster point declaration date must be in the past message should be displayed$/) do
  MonsterPointsPage.new.check_is_displaying_message I18n.t("errors.messages.on_or_before", restriction: Date.today.to_formatted_s)
end

Then(/^a monster point declaration updated message should be displayed$/) do
  MonsterPointsPage.new.check_is_displaying_message I18n.t("user.monster_point_declaration.success.updated")
end

Then(/^a monster point adjustment requested message should be displayed$/) do
  MonsterPointsPage.new.check_is_displaying_message I18n.t("user.monster_point_adjustment.success.created")
end

Then(/^a monster point adjustment date must be in the past message should be displayed$/) do
  MonsterPointsPage.new.check_is_displaying_message I18n.t("errors.messages.on_or_before", restriction: Date.today.to_formatted_s)
end

Then(/^a home page cannot be deleted message should be displayed$/) do
  PagesPage.new.check_is_displaying_message I18n.t("page.failure.home_deletion")
end

Then(/^a page not available message should be displayed$/) do
  HomePage.new.check_is_displaying_message I18n.t("devise.failure.unauthenticated")
end

Then(/^a page deleted message should be displayed$/) do
  PagesPage.new.check_is_displaying_message I18n.t("page.success.deleted")
end

Then(/^a page updated message should be displayed$/) do
  UserDefinedPage.new.check_is_displaying_message I18n.t("page.success.updated")
end

Then(/^a page created message should be displayed$/) do
  UserDefinedPage.new.check_is_displaying_message I18n.t("page.success.created")
end

Then(/^a duplicate page title message is displayed$/) do
  UserDefinedPage.new.check_is_displaying_message I18n.t("page.validation.title_uniqueness")
end

Then(/^an empty page message is displayed$/) do
  UserDefinedPage.new.check_is_displaying_message I18n.t("errors.messages.blank", attribute: "Content")
end