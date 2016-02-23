Given(/^there is a message board$/) do
  @board = BoardTestHelper.create_board
end

Given(/^there is a Briefs board$/) do
  BoardTestHelper.create_board(id: Board::BRIEFS, name: "Briefs")
end

Given(/^there is a Debriefs board$/) do
  BoardTestHelper.create_board(id: Board::DEBRIEFS, name: "Debriefs")
end

When(/^the user posts a message to the board$/) do
  BoardPage.new.visit_page(board_path(@board)).and.post_message(containing_text: "Text to check for")
end

Then(/^the message appears on the message board$/) do
  BoardPage.new.visit_page(board_path(@board)).and.check_for_message(from: @user, containing_text: "Text to check for")
end

Then(/^a Brief Published message appears on the Briefs board$/) do
  BoardPage.new.visit_page(board_path(Board::BRIEFS)).and.check_for_message(from: @user, 
                                                                            containing_text: "Brief updated", 
                                                                            containing_link: game_path(@game),
                                                                            relating_to_game: @game)
end

Then(/^a Debrief Published message appears on the Debriefs board$/) do
  BoardPage.new.visit_page(board_path(Board::DEBRIEFS)).and.check_for_message(from: @user, 
                                                                              containing_text: "Debrief published", 
                                                                              containing_link: game_path(@game),
                                                                              relating_to_game: @game)
end
