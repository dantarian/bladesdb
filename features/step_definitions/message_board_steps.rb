# Set-up

Given(/^there is a message board$/) do
 BoardTestHelper.create_board
end

Given(/^the message board is closed$/) do
 BoardTestHelper.close_board(Board.first)
end

Given(/^there is a Briefs board$/) do
  BoardTestHelper.create_board(id: Board::BRIEFS, name: "Briefs")
end

Given(/^there is a Debriefs board$/) do
  BoardTestHelper.create_board(id: Board::DEBRIEFS, name: "Debriefs")
end

Given(/^there is a message from the user$/) do
  BoardTestHelper.create_message(Board.first, User.first, message: "First!")
end

Given(/^there is a message from the other user$/) do
  BoardTestHelper.create_message(Board.first, User.last, message: "Second!")
end

Given(/^there is an OOC message board$/) do
  board = BoardTestHelper.create_board
end

Given(/^there is an IC message board$/) do
  board = BoardTestHelper.create_board(name: "New IC Board", ic: true)
end

Given(/^there is a closed OOC message board$/) do
  board = BoardTestHelper.create_board(closed: true)
end

Given(/^there is a closed IC message board$/) do
  board = BoardTestHelper.create_board(name: "New IC Board", ic: true, closed: true)
end

# Actions

When(/^the user posts a message to the board$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.post_message(containing_text: "Text to check for")
end

When(/^the user creates a new OOC message board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the user creates a new IC message board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the user edits the message board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the user deletes the message board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the user converts it to an IC message board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the user converts it to an OOC message board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the user marks the board as closed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the user marks the board as open$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the user moves the IC board up the list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^the user moves the OOC board down the list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

# Validations

Then(/^the message should appear on the message board$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.check_for_message(from: User.first, containing_text: "Text to check for")
end

Then(/^a Brief Published message should appear on the Briefs board$/) do
  BoardPage.new.visit_page(board_path(Board::BRIEFS)).and.check_for_message(from: User.first,
                                                                            containing_text: "Brief updated",
                                                                            containing_link: game_path(Game.first),
                                                                            relating_to_game: Game.first)
end

Then(/^a Debrief Published message should appear on the Debriefs board$/) do
  BoardPage.new.visit_page(board_path(Board::DEBRIEFS)).and.check_for_message(from: User.first,
                                                                              containing_text: "Debrief published",
                                                                              containing_link: game_path(Game.first),
                                                                              relating_to_game: Game.first)
end

Then(/^the user should see a short name and no email on the message$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.check_for_message(from: User.first)
end

Then(/^an OOC message board should be created$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^an IC message board should be created$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the OOC message board should be updated$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^a message board deleted message should be displayed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the OOC message board should be deleted$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the IC message board should be deleted$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the board should become an IC message board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the board should become an OOC message board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the board shoud be moved to the closed boards list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the user should not be able to post a message to the board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the board shoud be moved to the open boards list$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the user should be able to post a message to the board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the IC board should appear above the OOC board$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
