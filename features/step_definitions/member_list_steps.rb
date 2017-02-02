Given(/^the admin user is logged in$/) do
  LoginPage.new.visit_page(new_user_session_path).and.login_with_credentials User.all.third.username, UserTestHelper::DEFAULT_PASSWORD
end

Given(/^the user is a player of the first game$/) do
  user = UserTestHelper.create_or_find_user
  character = CharacterTestHelper.create_character(user)
  CharacterTestHelper.approve_character(user)
  GameTestHelper.add_player user, character, to: Game.first
end

Given(/^the other user is a monster of the first game$/) do
  user = UserTestHelper.create_or_find_another_user
  GameTestHelper.add_monster user, to: Game.first
end

Given(/^the other user is a player of the second game$/) do
  user = UserTestHelper.create_or_find_another_user
  character = CharacterTestHelper.create_character(user, name: "Nijel the Destroyer")
  CharacterTestHelper.approve_character(user)
  GameTestHelper.add_player user, character, to: Game.all.second
end

Given(/^the user is a GM for the first game$/) do
  GameTestHelper.add_gamesmaster User.first, to: Game.first
end

Given(/^the other user is a GM for the first game$/) do
  GameTestHelper.add_gamesmaster User.all.second, to: Game.first
end

Given(/^the other user is a GM for the second game$/) do
  GameTestHelper.add_gamesmaster User.all.second, to: Game.all.second
end

# Actions

When(/^the user suspends the other user$/) do
  MembersPage.new.suspend_user
end

When(/^the user unsuspends the other user$/) do
  MembersPage.new.unsuspend_user
end

When(/^the user deletes the other user$/) do
  MembersPage.new.delete_user
end

When(/^the user undeletes the other user$/) do
  MembersPage.new.undelete_user
end

When(/^the user purges the other user$/) do
  MembersPage.new.purge_user
end

When(/^the user approves the other user$/) do
  MembersPage.new.approve_user
end

When(/^the user rejects the other user$/) do
  MembersPage.new.reject_user
end

When(/^the user resends the activation email for the other user$/) do
  MembersPage.new.resend_activation
end

When(/^the user grants the committee role to the other user$/) do
  MembersPage.new.grant_role("committee")
end

When(/^the user revokes the committee role from the other user$/) do
  MembersPage.new.revoke_role("committee")
end

When(/^the user grants the web-only role to the other user$/) do
  MembersPage.new.grant_role("webonly")
end

When(/^the user revokes the web-only role from the other user$/) do
  MembersPage.new.revoke_role("webonly")
end

When(/^the user opens the role dialog$/) do
  MembersPage.new.open_role_dialog
end


When(/^the admin user merges the second user into the first user$/) do
  MembersPage.new.visit_page(users_path).and.merge_users
end

# Validations

Then(/^the user should be in the Active Members table$/) do
  MembersPage.new.check_for_active_user(User.first)
end

Then(/^the other user should be in the Active Members table$/) do
  MembersPage.new.check_for_active_user(User.all.second)
end

Then(/^the other user should be in the Web\-only Members table$/) do
  MembersPage.new.check_for_webonly_user(User.all.second)
end

Then(/^the other user should be in the Suspended table$/) do
  MembersPage.new.check_for_suspended_user(User.all.second)
end

Then(/^the other user should be in the Deleted table$/) do
  MembersPage.new.check_for_deleted_user(User.all.second)
end

Then(/^the user should not see any other tables$/) do
  MembersPage.new.check_for_table(table: "pending", display: false)
  MembersPage.new.check_for_table(table: "suspended", display: false)
  MembersPage.new.check_for_table(table: "deleted", display: false)
  MembersPage.new.check_for_table(table: "gm-created", display: false)
end

Then(/^the user should not see any user management links$/) do
  MembersPage.new.check_for_links(text: "Delete", display: false)
  MembersPage.new.check_for_links(text: "Suspend", display: false)
  MembersPage.new.check_for_links(text: "Edit roles", display: false)
  MembersPage.new.check_for_links(text: "Unsuspend", display: false)
  MembersPage.new.check_for_links(text: "Undelete", display: false)
  MembersPage.new.check_for_links(text: "Purge", display: false)
  MembersPage.new.check_for_links(text: "Approve", display: false)
  MembersPage.new.check_for_links(text: "Reject", display: false)
  MembersPage.new.check_for_links(text: "Resend activation", display: false)
end

Then(/^the user should not see a merge users link$/) do
  MembersPage.new.check_for_links(text: "Merge users", display: false)
end

Then(/^the user should see all other tables$/) do
  MembersPage.new.check_for_table(table: "pending")
  MembersPage.new.check_for_table(table: "suspended")
  MembersPage.new.check_for_table(table: "deleted")
  MembersPage.new.check_for_table(table: "gm-created")
end

Then(/^the user should see all user management links$/) do
  MembersPage.new.check_for_links(text: "Delete")
  MembersPage.new.check_for_links(text: "Suspend")
  MembersPage.new.check_for_links(text: "Edit roles")
  MembersPage.new.check_for_links(text: "Undelete")
  MembersPage.new.check_for_links(text: "Unsuspend")
  MembersPage.new.check_for_links(text: "Purge")
  MembersPage.new.check_for_links(text: "Approve")
  MembersPage.new.check_for_links(text: "Reject")
  MembersPage.new.check_for_links(text: "Resend activation")
end

Then(/^the user should see committee user management links$/) do
  MembersPage.new.check_for_links(text: "Delete")
  MembersPage.new.check_for_links(text: "Suspend")
  MembersPage.new.check_for_links(text: "Edit roles")
  MembersPage.new.check_for_links(text: "Undelete")
  MembersPage.new.check_for_links(text: "Unsuspend")
  MembersPage.new.check_for_links(text: "Resend activation")
end

Then(/^the user should not see admin user management links$/) do
  MembersPage.new.check_for_links(text: "Approve", display: false)
  MembersPage.new.check_for_links(text: "Reject", display: false)
  MembersPage.new.check_for_links(text: "Purge", display: false)
end

Then(/^the user should see a merge users link$/) do
  MembersPage.new.check_for_links(text: "Merge users")
end

Then(/^the user should see an unsuspend link$/) do
  MembersPage.new.check_for_links(text: "Unsuspend")
end

Then(/^the user should see an undelete link$/) do
  MembersPage.new.check_for_links(text: "Undelete")
end

Then(/^the user should see a purge link$/) do
  MembersPage.new.check_for_links(text: "Purge")
end

Then(/^the user should not see a purge link$/) do
  MembersPage.new.check_for_links(text: "Purge", display: false)
end

Then(/^the other user should no longer exist$/) do
  MembersPage.new.check_for_links(text: "Ann Other", display: false)
end

Then(/^the second user should no longer exist$/) do
  MembersPage.new.check_for_links(text: "Ann Other", display: false)
end

Then(/^an activation email should be sent to the other user$/) do
  EmailTestHelper.count_emails_with_subject(User.all.second.email, I18n.t("devise.mailer.confirmation_instructions.subject")).should == 2
end

Then(/^an approval email should be sent to the other user$/) do
  EmailTestHelper.count_emails_with_subject(User.all.second.email, I18n.t("email_subjects.approved")).should == 1
end

Then(/^the other user should have the committee role marker$/) do
  MembersPage.new.check_for_role(rolename: "committee", user: User.all.second)
end

Then(/^the other user should not have the committee role marker$/) do
  MembersPage.new.check_for_role(rolename: "committee", user: User.all.second, display: false)
end

Then(/^the user cannot grant the administrator role$/) do
  MembersPage.new.check_role_permission(rolename: "administrator")
end

Then(/^the user cannot grant the committee role$/) do
  MembersPage.new.check_role_permission(rolename: "committee")
end

Then(/^the user cannot grant the characterref role$/) do
  MembersPage.new.check_role_permission(rolename: "characterref")
end

Then(/^the first user should still have their character$/) do
  CharactersPage.new.visit_page(characters_path).and.check_for_character(User.first, Character.first)
end

Then(/^the first user should have the second user's character$/) do
  CharactersPage.new.visit_page(characters_path).and.check_for_character(User.first, Character.all.second)
end

Then(/^the first user should still have their message board post$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.check_for_message(from: User.first, containing_text: "First!")
end

Then(/^the first user should have the second user's message board post$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.check_for_message(from: User.first, id: 2, containing_text: "Second!")
end

Then(/^the first user should still have their game application$/) do
  GamePage.new.visit_page(game_path(Game.first)).and.check_for_application(from: User.first, containing_text: "First!")
end

Then(/^the first user should have the second user's game application$/) do
  GamePage.new.visit_page(game_path(Game.first)).and.check_for_application(from: User.first, id: 2, containing_text: "Second!")
end

Then(/^the first user should be able to log in as themselves$/) do
  HomePage.new.visit_page(root_path).and.log_out
  LoginPage.new.visit_page(new_user_session_path).and.login_with_credentials "normaluser", UserTestHelper::DEFAULT_PASSWORD
  HomePage.new.check_is_displaying_message I18n.t("devise.sessions.signed_in")
end

Then(/^the first user should not be able to log in as the second user$/) do
  HomePage.new.visit_page(root_path).and.log_out
  LoginPage.new.visit_page(new_user_session_path).and.login_with_credentials "anotheruser", UserTestHelper::DEFAULT_PASSWORD
  HomePage.new.check_is_displaying_message I18n.t("devise.failure.not_found_in_database")
end

Then(/^the first user should not be a first aider$/) do
  MembersPage.new.visit_page(users_path).and.check_for_role(rolename: "firstaider", user: User.first, display: false)
end

Then(/^the first user should still be a player on the first game$/) do
  GamePage.new.visit_page(game_path(Game.first)).and.check_for_player(User.first, User.first.characters.first)
end

Then(/^the first user should be a player on the second game$/) do
  GamePage.new.visit_page(game_path(Game.all.second)).and.check_for_player(User.first, User.first.characters.second)
end

Then(/^the first user should still be on the debrief of the first game$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.check_for_player(1, 1, "Norman Normal", "Testy McTesterson")
end

Then(/^the first user should be on the debrief of the second game$/) do
  DebriefPage.new.visit_page(game_path(Game.all.second)).and.check_for_player(2, 2, "Norman Normal",  "Nijel the Destroyer")
end

Then(/^the first user should still be a gm on the first game$/) do
  GamePage.new.visit_page(game_path(Game.first)).and.check_for_gm(User.first)
end

Then(/^the first user should be a gm on the second game$/) do
  GamePage.new.visit_page(game_path(Game.all.second)).and.check_for_gm(User.first)
end

Then(/^the first user should still have their monster point declaration$/) do
  MonsterPointsPage.new.visit_page(monster_points_user_path(User.first)).and.check_for_declaration(20)
end

Then(/^the first user should not have the second user's monster point declaration$/) do
  MonsterPointsPage.new.visit_page(monster_points_user_path(User.first)).and.check_for_declaration(15, display: false)
end

Then(/^the first user should have the second user's monster point declaration$/) do
  MonsterPointsPage.new.visit_page(monster_points_user_path(User.first)).and.check_for_declaration(15)
end

Then(/^the first user should still have their monster point adjustment$/) do
  MonsterPointsPage.new.visit_page(monster_points_user_path(User.first)).and.check_for_adjustment(20)
end

Then(/^the first user should not have the second user's monster point adjustment$/) do
  MonsterPointsPage.new.visit_page(monster_points_user_path(User.first)).and.check_for_adjustment(15, display: false)
end

Then(/^the first user should have the second user's monster point adjustment$/) do
  MonsterPointsPage.new.visit_page(monster_points_user_path(User.first)).and.check_for_adjustment(15)
end

Then(/^the first user should be on the debrief of the game$/) do
  DebriefPage.new.visit_page(game_path(Game.first)).and.check_for_player(1, 1, "Norman Normal", "Testy McTesterson")
end

Then(/^the first user should have the second user's gm\-created character$/) do
  CharactersPage.new.visit_page(characters_path).and.check_for_undeclared_character("Norman Normal", "Ginny Greenteeth")
end
