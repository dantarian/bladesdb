# Action steps

When(/^the character ref approves the character point adjustment$/) do
  ThingsApprovalsPage.new.visit_page(approvals_path).and.approve_character_point_adjustment
end

When(/^the character ref rejects the character point adjustment$/) do
  ThingsApprovalsPage.new.visit_page(approvals_path).and.reject_character_point_adjustment  
end
