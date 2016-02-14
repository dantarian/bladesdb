Given(/^there is a Briefs board$/) do
  BoardsTestHelper.create_board(:id => Board::BRIEFS, :title => "Briefs")
end

Given(/^there is a Debriefs board$/) do
  BoardsTestHelper.create_board(:id => Board::DEBRIEFS, :title => "Debriefs")
end

Then(/^a Brief Published message appears on the Briefs board$/) do
  BoardPage.visit_page_for(Board::BRIEFS).and.check_for_message(:from => @user, 
                                                                :containing_text => "Brief updated", 
                                                                :containing_link_to_game => @game)
end

Then(/^a Debrief Published message appears on the Briefs board$/) do
  BoardPage.visit_page_for(Board::DEBRIEFS).and.check_for_message(:from => @user, 
                                                                  :containing_text => "Debrief published", 
                                                                  :containing_link_to_game => @game)
end
