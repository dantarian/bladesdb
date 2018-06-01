# Setup steps

Given(/^there is a Terms and Conditions statement$/) do
  AcceptableTestHelper.add_terms_and_conditions(text: "Some terms and conditions", timestamp: 2.years.ago)
end

Given(/^there is a new Terms and Conditions statement$/) do
  AcceptableTestHelper.add_terms_and_conditions(text: "Some terms and conditions", timestamp: 1.day.ago)
end

# Action steps

When(/^the user accepts the Terms and Conditions$/) do
  AcceptablePage.new.accept
end

When(/^the user rejects the Terms and Conditions$/) do
  AcceptablePage.new.reject
end

When(/^the user accepts that their account will be suspended$/) do
  AcceptablePage.new.confirm_reject
end

# Verification steps

Then(/^the user should see the Terms and Conditions Acceptance screen$/) do
  current_path.should == terms_and_conditions_user_path(User.first.id)
end
