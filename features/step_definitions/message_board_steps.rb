# Set-up

Given(/^there is an OOC message board$/) do
 BoardTestHelper.create_board
end

Given(/^there is another OOC message board$/) do
 BoardTestHelper.create_board(name: "New OOC Board 2", order: 2)
end

Given(/^the message board is closed$/) do
 BoardTestHelper.close_board(Board.first)
end

Given(/^there is an IC message board$/) do
 BoardTestHelper.create_board(name: "New IC Board", ic: true, order: 3)
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

Given(/^there is a message on the OOC message board$/) do
  BoardTestHelper.create_message(Board.where(in_character: false).first, User.first, message: "Text to check for")
end

Given(/^there is a message on the IC message board$/) do
  BoardTestHelper.create_message(Board.where(in_character: true).first, User.first, name: "Character Name", message: "First!")
end

Given(/^there is a message from the other user$/) do
  BoardTestHelper.create_message(Board.first, User.last, message: "Second!")
end

Given(/^there is a closed OOC message board$/) do
  BoardTestHelper.create_board(closed: true)
end

Given(/^there is a closed IC message board$/) do
  BoardTestHelper.create_board(name: "New IC Board", ic: true, closed: true)
end

# Actions

When(/^the user posts a message to the board$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.post_message(containing_text: "Text to check for")
end

When(/^the user posts a message to the board as the character$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.post_message(from: Character.first,
                                                                     containing_text: "Text to check for")
end

When(/^the user posts a message to the board as an arbitrary poster$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.post_message(from: "Arbitrary Poster",
                                                                     containing_text: "Text to check for")
end

When(/^the user creates a new OOC message board$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.create_board(name: "New OOC Board", blurb: "This is a new OOC board.")
end

When(/^the user creates a new IC message board$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.create_board(name: "New IC Board", blurb: "This is a new IC board.", ic: true)
end

When(/^the user edits the OOC message board$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.update_board(name: "New OOC Board", new_name: "New OOC Board 2", blurb: "This is an updated OOC board.")
end

When(/^the user edits the IC message board$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.update_board(name: "New IC Board", new_name: "New IC Board 2", blurb: "This is an updated IC board.")
end

When(/^the user deletes the OOC message board$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.delete_board(name: "New OOC Board")
end

When(/^the user deletes the IC message board$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.delete_board(name: "New IC Board")
end

When(/^the user converts it to an IC message board$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.update_board(name: "New OOC Board", ic: true)
end

When(/^the user converts it to an OOC message board$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.update_board(name: "New IC Board", ic: false)
end

When(/^the user marks the OOC board as closed$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.close_board(name: "New OOC Board")
end

When(/^the user marks the IC board as closed$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.close_board(name: "New IC Board")
end

When(/^the user marks the OOC board as open$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.open_board(name: "New OOC Board")
end

When(/^the user marks the IC board as open$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.open_board(name: "New IC Board")
end

When(/^the user moves the IC board up the list$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.move_board_up(name: "New IC Board")
end

When(/^the user moves the OOC board down the list$/) do
  MessageBoardsAdminPage.new.visit_page(admin_boards_path).and.move_board_down(name: "New OOC Board")
end

When(/^the user views the list of message boards$/) do
  BoardsPage.new.visit_page(boards_path)
end

When(/^the user visits the OOC message board$/) do
  BoardPage.new.visit_page(board_path(Board.where(in_character: false).first.id))
end

When(/^the user marks the boards as read$/) do
  BoardsPage.new.visit_page(boards_path).and.click_on("Mark all boards read")
end

When(/^the user deletes the message$/) do
  BoardPage.new.visit_page(board_path(Board.first.id)).and.delete_message
end

# Validations

Then(/^the message should appear on the message board$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.check_for_message(from: User.first, 
                                                                          containing_text: "Text to check for")
end

Then(/^the message should not appear on the message board$/) do
  BoardPage.new.visit_page(board_path(Board.first))
           .and.check_for_no_message(containing_text: "Text to check for")
end

Then(/^a placeholder should indicate that the message has been deleted$/) do
  BoardPage.new.visit_page(board_path(Board.first))
           .and.check_for_deleted_message_placeholder
end

Then(/^the message should appear on the message board from the character$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.check_for_message(from: Character.first, 
                                                                          containing_text: "Text to check for")
end

Then(/^the message should appear on the message board from the arbitrary poster$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.check_for_message(from: "Arbitrary Poster", 
                                                                          containing_text: "Text to check for")
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
  MessageBoardsAdminPage.new.find_board(name: "New OOC Board")
end

Then(/^an IC message board should be created$/) do
  MessageBoardsAdminPage.new.find_board(name: "New IC Board", ic: true)
end

Then(/^the OOC message board should be updated$/) do
  MessageBoardsAdminPage.new.find_board(name: "New OOC Board 2")
end

Then(/^the IC message board should be updated$/) do
  MessageBoardsAdminPage.new.find_board(name: "New IC Board 2", ic: true)
end

Then(/^the OOC message board should be deleted$/) do
  MessageBoardsAdminPage.new.find_board(name: "New OOC Board", deleted: true)
end

Then(/^the IC message board should be deleted$/) do
  MessageBoardsAdminPage.new.find_board(name: "New IC Board", deleted: true)
end

Then(/^the board should become an IC message board$/) do
  MessageBoardsAdminPage.new.find_board(name: "New OOC Board", ic: true)
end

Then(/^the board should become an OOC message board$/) do
  MessageBoardsAdminPage.new.find_board(name: "New IC Board", ic: false)
end

Then(/^the OOC board should be moved to the closed boards list$/) do
  MessageBoardsAdminPage.new.find_board(name: "New OOC Board", closed: true)
end

Then(/^the IC board should be moved to the closed boards list$/) do
  MessageBoardsAdminPage.new.find_board(name: "New IC Board", ic: true, closed: true)
end

Then(/^the user should not be able to post a message to the OOC board$/) do
  MessageBoardsAdminPage.new.check_for_postability(name: "New OOC Board", post: false)
end

Then(/^the user should not be able to post a message to the IC board$/) do
  MessageBoardsAdminPage.new.check_for_postability(name: "New IC Board", post: false)
end

Then(/^the OOC board should be moved to the open boards list$/) do
  MessageBoardsAdminPage.new.find_board(name: "New OOC Board", closed: false)
end

Then(/^the IC board should be moved to the open boards list$/) do
  MessageBoardsAdminPage.new.find_board(name: "New IC Board", ic: true, closed: false)
end

Then(/^the user should be able to post a message to the OOC board$/) do
  MessageBoardsAdminPage.new.check_for_postability(name: "New OOC Board", post: true)
end

Then(/^the user should be able to post a message to the IC board$/) do
  MessageBoardsAdminPage.new.check_for_postability(name: "New IC Board", post: true)
end

Then(/^the IC board should appear between the OOC boards$/) do
  MessageBoardsAdminPage.new.check_for_position("New OOC Board", "New OOC Board 2")
end

Then(/^the OOC board should appear between the other OOC and IC boards$/) do
  MessageBoardsAdminPage.new.check_for_position("New OOC Board 2", "New IC Board")
end

Then(/^there should be (\d+) unread messages? for the OOC message board$/) do |messages|
  BoardsPage.new.visit_page(boards_path).and.check_for_unread_messages(messages)
end

Then(/^there should be (\d+) unread messages? for the IC message board$/) do |messages|
  BoardsPage.new.visit_page(boards_path).and.check_for_unread_messages(messages, ic_board: true)
end
