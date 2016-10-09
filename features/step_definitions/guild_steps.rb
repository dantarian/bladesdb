# Set-up

Given(/^the Guild has branches$/) do
  GuildTestHelper.create_guild_branch
end

Given(/^the Guild has another branch$/) do
  GuildTestHelper.create_guild_branch(name: "Branch 2")
end

Given(/^the character is a member of the last branch of the Guild$/) do
  GuildTestHelper.join_guild(Character.first, Guild.last, GuildBranch.last)
end

Given(/^there is a Guild$/) do
  GuildTestHelper.create_guild
end

Given(/^there is another Guild$/) do
  GuildTestHelper.create_guild(name: "Test Guild 2")
end

Given(/^the character is a member of the Guild$/) do
  GuildTestHelper.join_guild(Character.first, Guild.last)
end

Given(/^the character is Guildless$/) do
  GuildTestHelper.join_guild(Character.first, nil)
end

Given(/^the character joined the Guild at rank (.*?)$/) do |rank|
  unless rank.to_i == 0 
    CharacterTestHelper.update_starting_rank(rank.to_i*10)
    GuildTestHelper.update_start_rank(rank.to_i*10)
  end
end

Given(/^the character has an application to join the Guild$/) do
  GuildTestHelper.join_guild(Character.first, Guild.find_by(name: "Test Guild"), approved: nil)
end

Given(/^the character has an application to join another Guild$/) do
  GuildTestHelper.join_guild(Character.first, Guild.find_by(name: "Test Guild 2"), approved: nil)
end

Given(/^the character has an application to leave the Guild$/) do
  GuildTestHelper.leave_guild(Character.first)
end

# Actions

When(/^the character asks to join the Guild$/) do
  CharacterProfilePage.new.visit_page(character_path(1)).and.join_guild("Test Guild")
end

When(/^the character asks to join the other Guild$/) do
  CharacterProfilePage.new.visit_page(character_path(1)).and.change_guild("Test Guild 2")
end

When(/^the character asks to join another branch of the Guild$/) do
  CharacterProfilePage.new.visit_page(character_path(1)).and.change_branch("Branch 2")
end

When(/^the character cancels their request to join a Guild$/) do
  CharacterProfilePage.new.visit_page(character_path(1)).and.cancel_guild_change
end

When(/^the character asks to leave the Guild$/) do
  CharacterProfilePage.new.visit_page(character_path(1)).and.leave_guild
end

When(/^the character cancels their request to leave the Guild$/) do
  CharacterProfilePage.new.visit_page(character_path(1)).and.cancel_guild_change
end

# Validations

Then(/^an application to join the Guild should be displayed on the character's profile$/) do
  CharacterProfilePage.new.check_for_guild("Test Guild", branch: nil, state: "join_pending")
end

Then(/^an application to join the new Guild should be displayed on the character's profile$/) do
  CharacterProfilePage.new.check_for_guild("Test Guild 2", branch: nil, state: "change_pending")
end

Then(/^an application to join the new branch should be displayed on the character's profile$/) do
  CharacterProfilePage.new.check_for_guild("Test Guild", branch: "Branch 1", state: "change_pending")
end

Then(/^an application to leave the Guild should be shown on the character's profile$/) do
  CharacterProfilePage.new.check_for_guild("Test Guild", branch: nil, state: "leave_pending")
end

Then(/^the old Guild should be shown on the character's profile$/) do
  CharacterProfilePage.new.check_for_guild("Test Guild", branch: nil)
end

Then(/^no Guild should be shown on the character's profile$/) do
  CharacterProfilePage.new.check_for_guild("No guild", branch: nil)
end