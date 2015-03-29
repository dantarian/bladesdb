include ApplicationHelper

Given(/^there is (.*?) money to display$/) do |money|
  @money = money.to_i
end

Then(/^the money is displayed as (.*?)$/) do |expected|
  expect(money_for_display(@money)).to eq(expected)
end

