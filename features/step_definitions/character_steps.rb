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

Given(/^the other user has another character$/) do
  CharacterTestHelper.create_character(User.all.second, name: "Brian Bloodaxe")
  CharacterTestHelper.approve_character(User.all.second, Character.last)
end

Given(/^the other user has a GM\-created character$/) do
  CharacterTestHelper.create_undeclared_character(User.all.second, name: "Ginny Greenteeth")
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

Given(/^the user has a character declared one month before the monster spend cut\-off$/) do
  CharacterTestHelper.create_character(User.first, declared_on: '2016-12-07')
  CharacterTestHelper.approve_character(User.first)
end

Given(/^the character has played (\d+) games$/) do |games|
  games.to_i.times do |offset|
    GameTestHelper.create_debriefed_game_for_first_character(10, offset)
  end
end

Given(/^the character has played (\d+) games, earning (\d+) character points per game$/) do |games, points|
  games.to_i.times do |offset|
    GameTestHelper.create_debriefed_game_for_first_character(points.to_i, offset)
  end
end

Given(/^the character has bought (\d+) character points for (\d+) monster points$/) do |cp, mp|
  MonsterPointSpendTestHelper.create_monster_point_spend(Character.first, character_points_gained: cp, monster_points_spent: mp)
end

Given(/^the character has (\d+) groats?$/) do |groats|
  CharacterTestHelper.set_starting_florins(Character.first, groats.to_i * 10)
end

Given(/^the other character has (\d+) groats?$/) do |groats|
  CharacterTestHelper.set_starting_florins(Character.last, groats.to_i * 10)
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

When(/^the user updates their character's bio$/) do
  CharacterPage.new.visit_page(character_path(1)).and.update_bio("Was born and is still not dead.")
end

When(/^the user updates their character's date of birth$/) do
  CharacterPage.new.visit_page(character_path(1)).and.update_date_of_birth(Date.new(1999, 3, 13))
end

When(/^the user updates their character's address$/) do
  CharacterPage.new.visit_page(character_path(1)).and.update_address("The Barony")
end

When(/^the user updates their character's notes$/) do
  CharacterPage.new.visit_page(character_path(1)).and.update_notes("Has a sword.")
end

When(/^the user updates their character's private notes$/) do
  CharacterPage.new.visit_page(character_path(1)).and.update_private_notes("Secretly misses their mum.")
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

When(/^the user recycles the character$/) do
  CharacterPage.new.visit_page(character_path(1)).and.recycle_character
end

When(/^the user retires the character$/) do
  CharacterPage.new.visit_page(character_path(1)).and.retire_character
end

When(/^the user reactivates the character$/) do
  CharacterPage.new.visit_page(character_path(1)).and.reactivate_character
end

When(/^the user perm-kills the character$/) do
  CharacterPage.new.visit_page(character_path(1)).and.permkill_character
end

When(/^the user requests resurrection of the character$/) do
  CharacterPage.new.visit_page(character_path(1)).and.request_resurrection
end

When(/^the user tries to recycle the character$/) do
  CharacterPage.new.visit_page(character_path(1))
end

When(/^the user transfers (\d+) groats? from the character to the other (?:user's )?character$/) do |groats|
  CharacterPage.new.visit_page(character_path(1)).and.transfer_money(groats.to_i * 10, to: Character.last)
end

When(/^the user transfers (\d+) groats? from the character to an NPC$/) do |groats|
  CharacterPage.new.visit_page(character_path(1)).and.transfer_money(groats.to_i * 10, to: "NPC")
end

When(/^the user transfers (\d+) groats? from an NPC to the character$/) do |groats|
  CharacterPage.new.visit_page(character_path(1)).and.transfer_money_from_npc(groats.to_i * 10)
end

When(/^the user tries to transfer (\d+) groats? from the character to the other character$/) do |groats|
  CharacterPage.new.visit_page(character_path(1)).and.start_money_transfer
end

When(/^the user tries to transfer (\d+) groats? from the character to their character$/) do |groats|
  CharacterPage.new.visit_page(character_path(1)).and.start_money_transfer
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
  CharacterPage.new.check_for_character_name("Robert McLogin")
end

Then(/^the updated bio should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_biography("Was born and is still not dead.")
end

Then(/^the updated date of birth should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_date_of_birth("13 Mar 99 AE")
end

Then(/^the updated address should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_address("The Barony")
end

Then(/^the updated notes should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_notes("Has a sword.")
end

Then(/^the updated private notes should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_private_notes("Secretly misses their mum.")
end

Then(/^the title should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_character_title("Stupendous")
end

Then(/^no title should be displayed on the character's profile$/) do
  CharacterPage.new.check_for_character_title(nil)
end

Then(/^the character should be recycled$/) do
  CharacterPage.new.visit_page(character_path(1)).and.check_for_state("Recycled")
end

Then(/^the character should be retired$/) do
  CharacterPage.new.visit_page(character_path(1)).and.check_for_state("Retired")
end

Then(/^the character should be active$/) do
  CharacterPage.new.visit_page(character_path(1)).and.check_for_state("Active")
end

Then(/^the character should be provisionally active$/) do
  CharacterPage.new.visit_page(character_path(1)).and.check_for_state("Active (Not yet approved)")
end

Then(/^the character should be dead$/) do
  CharacterPage.new.visit_page(character_path(1)).and.check_for_state("Dead")
end

Then(/^the user should be unable to recycle the character$/) do
    CharacterPage.new.visit_page(character_path(1)).and.confirm_absence_of_recycle_link
end

Then(/^the character should have (\d+) groats?$/) do |groats|
  CharacterPage.new.visit_page(character_path(1)).and.check_for_money(money: "#{groats}g")
end

Then(/^the other character should have (\d+) groats?$/) do |groats|
  CharacterPage.new.visit_page(character_path(Character.last.id)).and.check_for_money(money: "#{groats}g")
end

Then(/^the user should be unable to transfer money (?:between|to) their own characters$/) do
  CharacterPage.new.check_for_target_character_list_without_own_characters
end

Then(/^the user should be told they cannot transfer more money than they have$/) do
  CharacterPage.new.check_for_not_enough_money_available_message
end