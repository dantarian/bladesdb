# Conditions

Given(/^the user has a character$/) do
  CharacterTestHelper.create_character(User.first)
  CharacterTestHelper.approve_character(User.first)
end

Given(/^the other user has a character$/) do
  CharacterTestHelper.create_character(User.all.second, name: "Nigel the Magnificent")
  CharacterTestHelper.approve_character(User.all.second, Character.all.second)
end

Given(/^the character is a player on the game$/) do
  game_attendance = GameAttendance.new(game_id: @game.id, user_id: @character.user_id, character_id: @character.id, attend_state: GameAttendance::PLAYING, confirm_state: GameAttendance::REQUESTED)
  game_attendance.save
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
  CharacterProfilePage.new.visit_page(character_path(1)).and.update_name("Robert McLogin")
end

When(/^the user tries to update their character's name to nothing$/) do
  CharacterProfilePage.new.visit_page(character_path(1)).and.update_name("")
end

When(/^the user gives their character a custom title$/) do
  CharacterProfilePage.new.visit_page(character_path(1)).and.update_title(title: "Stupendous")
end

When(/^the user gives their character no title$/) do
  CharacterProfilePage.new.visit_page(character_path(1)).and.update_title(no_title: true)
end

# Validations

Then(/^the user should see a short user name and character link on the character$/) do
  CharactersPage.new.check_for_character(User.all.second, Character.first)
end

Then(/^the character should be created with the basic values$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterProfilePage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterProfilePage.new.check_for_money
end

Then(/^the character should be created with the Guild membership$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterProfilePage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterProfilePage.new.check_for_money
  CharacterProfilePage.new.check_for_guild("Test Guild")
end

Then(/^the character should be created with the Guild and branch membership$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterProfilePage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterProfilePage.new.check_for_money
  CharacterProfilePage.new.check_for_guild("Test Guild", branch: "Branch 1")
end

Then(/^the character should be created with the custom title$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterProfilePage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterProfilePage.new.check_for_money
  CharacterProfilePage.new.check_for_character_title("Badass")
end

Then(/^the character should be created with no title$/) do
  CharactersPage.new.click_link("Testy McTesterson")
  CharacterProfilePage.new.check_for_core_fields(state: "Active (Not yet approved)")
  CharacterProfilePage.new.check_for_money
  CharacterProfilePage.new.check_for_character_title(nil)
  CharacterProfilePage.new.check_for_guild("Test Guild")
end

Then(/^the updated name should be displayed on the character's profile$/) do
  CharacterProfilePage.new.check_for_core_fields(character_name: "Robert McLogin")
end

Then(/^the title should be displayed on the character's profile$/) do
  CharacterProfilePage.new.check_for_character_title("Stupendous")
end

Then(/^no title should be displayed on the character's profile$/) do
  CharacterProfilePage.new.check_for_character_title(nil)
end
