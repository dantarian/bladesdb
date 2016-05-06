Given(/^there is a message board$/) do
 BoardTestHelper.create_board
end

Given(/^the message board is closed$/) do
 BoardTestHelper.close_board(Board.first)
end

Given(/^there is an ic message board$/) do
 board = BoardTestHelper.create_board
 BoardTestHelper.make_board_ic(board)
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



When(/^the user posts a message to the board$/) do
  BoardPage.new.visit_page(board_path(Board.first)).and.post_message(containing_text: "Text to check for")
end



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
