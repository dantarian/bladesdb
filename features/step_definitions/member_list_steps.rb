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
  User.exists?(2).should == false
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