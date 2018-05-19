# Setup steps

Given(/^there is a Terms and Conditions statement$/) do
  AcceptableTestHelper.add_terms_and_conditions(text: "Some terms and conditions", timestamp: 2.years.ago)
end

# Action steps

# Verification steps
