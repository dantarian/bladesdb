# Conditions

Given(/^the user has a character$/) do
  CharacterTestHelper.create_character(User.first)
  CharacterTestHelper.approve_character(User.first)
end

Given(/^the user has another character$/) do
  CharacterTestHelper.create_character(User.first, name: "Second Character")
  CharacterTestHelper.approve_character(User.first, User.first.characters.second)
end

Given(/^the other user has an active character$/) do
  CharacterTestHelper.create_character(User.all.second)
  CharacterTestHelper.approve_character(User.all.second)
end

Given(/^the other user has a character$/) do
  CharacterTestHelper.create_character(User.all.second, name: "Nigel the Magnificent")
  CharacterTestHelper.approve_character(User.all.second, Character.all.second)
end

Given(/^the character is a player on the game$/) do
  game_attendance = GameAttendance.new(game_id: @game.id, user_id: @character.user_id, character_id: @character.id, attend_state: GameAttendance::PLAYING, confirm_state: GameAttendance::REQUESTED)
  game_attendance.save
end

Given(/^the character has (\d+) character points(?: before the games?)?$/) do |points|
  CharacterTestHelper.set_starting_points(Character.first, points)
end

Given(/^the character is pending approval$/) do
  CharacterTestHelper.make_pending(Character.first)
end

Given(/^the character is retired$/) do
  CharacterTestHelper.retire_character
end

Given(/^the character is dead$/) do
  CharacterTestHelper.permdeath_character
end

Given(/^the character is recycled$/) do
  CharacterTestHelper.recycle_character
end

Given(/^the character is undeclared$/) do
  CharacterTestHelper.undeclare_character
end

Given(/^there is a character point adjustment on the character$/) do
  CharacterTestHelper.add_character_point_adjustment(Character.first, 1, 2.days.ago, approved: true)
end

Given(/^there is a rejected character point adjustment on the character$/) do
  CharacterTestHelper.add_character_point_adjustment(Character.first, 1, 2.days.ago, approved: false)
end

Given(/^the character has a pending character point adjustment for (\d+) character points?$/) do |points|
  CharacterTestHelper.add_character_point_adjustment(Character.first, points.to_i, 2.days.ago, approved: nil)
end

Given(/^the character has a pending character point adjustment for \-(\d+) character points?$/) do |points|
  CharacterTestHelper.add_character_point_adjustment(Character.first, -(points.to_i), 2.days.ago, approved: nil)
end

Given(/^the user has an undeclared character$/) do
  CharacterTestHelper.create_undeclared_character(User.first)
end

# Actions

When(/^the character is at rank (.*?)$/) do |rank|
  CharacterTestHelper.add_character_point_adjustment(Character.first, rank.to_i*10 - Character.first.starting_points)
end

When(/^the user creates a new character with required values$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.create_new_character
end

When(/^the user creates a new character with a custom title$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.create_new_character(title: "Badass")
end

When(/^the user creates a new character with a Guild$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.create_new_character(guild: "Test Guild")
end

When(/^the user creates a new character with a Guild and branch$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.create_new_character(guild: "Test Guild", branch: "Branch 1")
end

When(/^the user creates a new character with no title$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.create_new_character(guild: "Test Guild", no_title: true)
end

When(/^the user tries to create a new character with no name$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.create_new_character(name: nil)
end

When(/^the user declares a new character with required values$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character
end

When(/^the user declares a new character with a Guild$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(guild: "Test Guild")
end

When(/^the user declares a new character with a Guild and branch$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(guild: "Test Guild", branch: "Branch 1")
end

When(/^the user declares a new character with a custom title$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(title: "Badass")
end

When(/^the user declares a new character with no title$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(guild: "Test Guild", no_title: true)
end

When(/^the user tries to declare a new character with no name$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(name: nil)
end

When(/^the user tries to declare a new character with null death thresholds$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(dts: nil)
end

When(/^the user tries to declare a new character with negative death thresholds$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(dts: -1)
end

When(/^the user tries to declare a new character with more death thresholds than their race allows$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(dts: 12)
end

When(/^the user tries to declare a new character with non\-numeric death thresholds$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(dts: "fish")
end

When(/^the user tries to declare a new character with null character points$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(rank: nil)
end

When(/^the user tries to declare a new character with less than (\d+) character points$/) do |rank|
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(rank: 10)
end

When(/^the user tries to declare a new character with non\-numeric character points$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(rank: "fish")
end

When(/^the user tries to declare a new character with null money$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(money: nil)
end

When(/^the user tries to declare a new character with negative money$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(money: -1)
end

When(/^the user tries to declare a new character with non\-numeric money$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(money: "fish")
end

When(/^the user tries to declare a new character with a Guild and null Guild starting points$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(guild: "Test Guild", joined_rank: nil)
end

When(/^the user tries to declare a new character with a Guild and negative Guild starting points$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(guild: "Test Guild", joined_rank: -1)
end

When(/^the user tries to declare a new character with a Guild and non\-numeric Guild starting points$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(guild: "Test Guild", joined_rank: "fish")
end

When(/^the user tries to declare a new character with a Guild and more Guild starting points than character points$/) do
  UserCharactersPage.new.visit_page(my_characters_path).and.declare_character(guild: "Test Guild", joined_rank: 30)
end

When(/^the user updates their character's name$/) do
  CharacterPage.new.visit_page(character_path(1)).and.update_name("Robert McLogin")
end

When(/^the user tries to update their character's name to nothing$/) do
  CharacterPage.new.visit_page(character_path(1)).and.update_name("")
end

When(/^the user gives their character a custom title$/) do
  CharacterPage.new.visit_page(character_path(1)).and.update_title(title: "Stupendous")
end

When(/^the user gives their character no title$/) do
  CharacterPage.new.visit_page(character_path(1)).and.update_title(no_title: true)
end

# Validations

Then(/^the user should see a short user name and character link on the character$/) do
  CharactersPage.new.check_for_character(User.all.second, Character.first)
end

Then(/^the character should have (\d+) character points$/) do |points|
  CharacterPage.new.visit_page(character_path(Character.first)).and.check_character_points(points.to_i)
end

Then(/^the character should be created with the basic values$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterPage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterPage.new.check_for_money
end

Then(/^the character should be created with the Guild membership$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterPage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterPage.new.check_for_money
  CharacterPage.new.check_for_guild("Test Guild")
end

Then(/^the character should be created with the Guild and branch membership$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterPage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterPage.new.check_for_money
  CharacterPage.new.check_for_guild("Test Guild", branch: "Branch 1")
end

Then(/^the character should be created with the custom title$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterPage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterPage.new.check_for_money
  CharacterPage.new.check_for_character_title("Badass")
end

Then(/^the character should be created with no title$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterPage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterPage.new.check_for_money
  CharacterPage.new.check_for_character_title(nil)
  CharacterPage.new.check_for_guild("Test Guild")
end

Then(/^the updated name should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_core_fields(character_name: "Robert McLogin")
end

Then(/^the title should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_character_title("Stupendous")
end

Then(/^no title should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_character_title(nil)
end
