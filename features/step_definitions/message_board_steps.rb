Given(/^there is a Briefs board$/) do
  BoardTestHelper.create_board(id: Board::BRIEFS, name: "Briefs")
end

Given(/^there is a Debriefs board$/) do
  BoardTestHelper.create_board(id: Board::DEBRIEFS, name: "Debriefs")
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
