# Set-up

Given(/^the character has a custom title$/) do
  CharacterTestHelper.update_title("Kickasso")
end

Given(/^the character has no title$/) do
  CharacterTestHelper.set_no_title
end

Given(/^the Guild has a static title$/) do
  GuildTestHelper.create_rank_title(Guild.last, 0, "Humact")
end

Given(/^the Guild has rank\-based titles$/) do
  GuildTestHelper.create_rank_title(Guild.last, 0, "Wizard")
  GuildTestHelper.create_rank_title(Guild.last, 100, "High Wizard")
  GuildTestHelper.create_rank_title(Guild.last, 500, "Arch Wizard")
end

Given(/^the Guild has rank\-based branch titles$/) do
  GuildTestHelper.create_rank_title(Guild.last, 0, "BRANCH")
  GuildTestHelper.create_rank_title(Guild.last, 100, "High BRANCH")
  GuildTestHelper.create_rank_title(Guild.last, 500, "Arch BRANCH")
end

Given(/^the Guild has static branch titles$/) do
  GuildTestHelper.create_rank_title(Guild.last, 0, "BRANCH")
end

# Validations

Then(/^the character should have no title$/) do
  Character.first.name_and_title.should eq(Character.first.name)
end

Then(/^the character's title should be (.*?)$/) do |title|
  Character.first.name_and_title.should start_with(title)
end

