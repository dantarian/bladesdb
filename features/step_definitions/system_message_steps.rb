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
  sleep 0.1 # Just enough delay to keep things in sync
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

Then(/^a character created message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("character.success.created")
end

Then(/^a character declared message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("character.success.declared")
end

Then(/^a character must have a name message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.blank", attribute: "Name")
end

Then(/^a character must have death thresholds message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.blank", attribute: "Death thresholds")
end

Then(/^a character cannot have less than zero death thresholds message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("character.validation.dts_less_than_zero")
end

Then(/^a character cannot have more death thresholds than their race message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("character.validation.dts_greater_than_race")
end

Then(/^a death thresholds must be a number message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.not_a_number", attribute: "Death thresholds")
end

Then(/^a character must have character points message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.blank", attribute: "Death thresholds")
end

Then(/^a character cannot have less than (\d+) character points message should be displayed$/) do |rank|
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.greater_than_or_equal_to", attribute: "Character points", count: rank)
end

Then(/^a character points must be a number message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.not_a_number", attribute: "Character points")
end

Then(/^a character must have money message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.blank", attribute: "Starting florins")
end

Then(/^a character cannot have negative money message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.greater_than_or_equal_to", attribute: "Starting florins", count: 0)
end

Then(/^a money must be a number message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.not_a_number", attribute: "Starting florins")
end

Then(/^a character cannot have negative Guild starting points message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.greater_than_or_equal_to", attribute: "Character Point Total at which you joined your current guild", count: 0)
end

Then(/^a Guild starting points must be a number message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("errors.messages.not_a_number", attribute: "Character Point Total at which you joined your current guild")
end

Then(/^a Guild starting points must be less than character points message should be displayed$/) do
  UserCharactersPage.new.check_is_displaying_message I18n.t("character.guild_membership.failure.more_than_character_points")
end

Then(/^a character updated message should be displayed$/) do
  CharacterPage.new.check_is_displaying_message I18n.t("character.success.updated")
end

Then(/^an application to join message should be displayed$/) do
  CharacterPage.new.check_is_displaying_message I18n.t("character.guild_membership.success.guild_changed")
end

Then(/^an application to change branch message should be displayed$/) do
  CharacterPage.new.check_is_displaying_message I18n.t("character.guild_membership.success.branch_changed")
end

Then(/^an application to leave message should be displayed/) do
  CharacterPage.new.check_is_displaying_message I18n.t("character.guild_membership.success.left_guild")
end

Then(/^an application cancelled message should be displayed$/) do
  CharacterPage.new.check_is_displaying_message I18n.t("character.guild_membership.success.cancelled")
end
