# Set-ups

Given(/^the character has a character point adjustment$/) do
  CharacterTestHelper.add_character_point_adjustment(Character.first, 20)
end

Given(/^the character has a pending character point adjustment$/) do
  CharacterTestHelper.add_character_point_adjustment(Character.first, 20, approved: nil)
end

Given(/^the character has a rejected character point adjustment$/) do
  CharacterTestHelper.add_character_point_adjustment(Character.first, 20, approved: false)
end

# Actions

When(/^the user requests a positive character point adjustment$/) do
  CharacterPage.new.visit_page(character_path(Character.first.id))
               .and.request_character_point_adjustment(Date.today, 17, "Test.")
end

When(/^the user requests a negative character point adjustment$/) do
  CharacterPage.new.visit_page(character_path(Character.first.id))
               .and.request_character_point_adjustment(Date.today, -16, "Test.")
end

# When(/^the user attempts to request a character point adjustment in the future$/) do
#   CharacterPage.new.visit_page(character_path(Character.first.id))
#                .and.request_character_point_adjustment(Date.today + 1.day, 20, "Test.")
# end

# When(/^the user attempts to create another character point adjustment$/) do
#   CharacterPage.new.visit_page(character_path(Character.first.id))
# end

# Validations

Then(/^a pending positive character point adjustment should be created$/) do
  CharacterPage.new.check_for_provisional_cp_adjustment(17)
end

# Then(/^the character should have a pending character point adjustment for (\d+) character points$/) do |points|
#   CharacterPage.new.visit_page(character_path(Character.first.id))
#                .and.check_for_provisional_cp_adjustment(points)
# end

Then(/^a pending negative character point adjustment should be created$/) do
  CharacterPage.new.check_for_provisional_cp_adjustment(-16)
end

Then(/^the character's character points should include the character point adjustment$/) do
  CharacterPage.new.visit_page(character_path(Character.first.id))
               .and.check_character_points(40)
end

Then(/^the character's character points should not include the character point adjustment$/) do
  CharacterPage.new.visit_page(character_path(Character.first.id))
               .and.check_character_points(20)
end

# Then(/^the user should not be allowed to create another character point adjustment$/) do
#   CharacterPage.new.check_for_links(element: "li#rank", text: "Request adjustment", display: false)
# end

Then(/^a character point adjustment requested message should be displayed$/) do
  CharacterPage.new.check_is_displaying_message I18n.t("character.points_adjustment.requested")
end

# Then(/^a character point adjustment date must be in the past message should be displayed$/) do
#   CharacterPage.new.check_is_displaying_message I18n.t("character.points_adjustment.validation.future_date")
# end
