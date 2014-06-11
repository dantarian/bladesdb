When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in("#{field}", with: value)
end

When(/^I click the "(.*?)" button$/) do |button|
  click_button(button)
end

When(/^I click on the "(.*?)" link for "(.*?)"$/) do |text, fieldname|
  page.find("li##{fieldname.gsub(/(\W)/, '').underscore}").find_link(text).click
end

When(/^I click on the "(.*?)" link for the "(?:.*?)" with the name "(.*?)"$/) do |text, name|
  page.find_link(name).first(:xpath,".//..//..").find_link(text).click
end

When(/^I click on the "(.*?)" link$/) do |text|
  page.find("div#content-space").find_link(text).click
end

When(/^I check "(.*?)"$/) do |text|
  text.downcase!
  page.find("label", text: text).click
end

When(/^I uncheck "(.*?)"$/) do |text|
  text.downcase!
  page.find("label", text: text).click
end

When(/^I take a screenshot$/) do
  page.save_screenshot('screenshot.png')
end

Then(/^a(?:n?) (.*?) message is displayed saying "(.*?)"$/) do |type, message|
  if type == "dialogue error"
    page.should have_css("div#errorExplanation")
    page.find("div#errorExplanation").should have_content(message, exact: true)
  else
    page.should have_css("div.#{type}")
    page.find("div.#{type}").should have_content(message, exact: true)
  end
end

Then(/^I can see(?:| my| their) "(.*?)" field$/) do |fieldname|
  page.find("li##{fieldname.gsub(/(\W)/, '').underscore}").find("div.fieldlabel").should have_content(fieldname)
end

Then(/^I can see(?:| my| their) "(.*?)" (?:|is|are|) "(.*?)"$/) do |fieldname, value|
  page.find("li##{fieldname.gsub(/(\W)/, '').underscore}").find("div.fieldcontents").should have_content(value)
end

Then(/^I can see(?:| my| their) "(.*?)" section$/) do |section|
  page.find("div##{section.gsub(/(\W)/, '').underscore}")
end

Then(/^there(?:| is| are|) no "(.*?)" links?$/) do |text|
  page.find("div#content-space").all("a").should_not have_content(text)
end

Then(/^there(?:| is| are|) an? "(.*?)" links?$/) do |text|
  page.find("div#content-space").find_link(text)
end

Then(/^an? "(.*?)" dialogue opens$/) do |title|
  page.find("span.ui-dialog-title").should have_content(title)
end

Then(/^the "(?:.*?)" with the name "(.*?)" is in the "(.*?)" table$/) do |name, table|
  table.downcase!
  page.find("table##{table}").find_link(name)
end

Then(/^there is no "(.*?)" table$/) do |table|
  table.downcase!
  page.should_not have_css("table##{table}")
end

Then(/^there is an? "(.*?)" table$/) do |table|
  table.downcase!
  page.should have_css("table##{table}")
end

Then(/^there is no "(.*?)" link for the "(?:.*?)" with the name "(.*?)"$/) do |text, name|
  page.find_link(name).first(:xpath,".//..//..").has_no_link?(text)
end

Then(/^there is an? "(.*?)" link for the "(?:.*?)" with the name "(.*?)"$/) do |text, name|
  page.find_link(name).first(:xpath,".//..//..").has_link?(text)
end

Then(/^the "(?:.*?)" with the name "(.*?)" does not appear on any table$/) do |name|
  page.has_no_link?(name)
end

Then(/^the "(?:.*?)" with the name "(.*?)" has the "(.*?)" marker$/) do |name, marker|
  page.find_link(name).first(:xpath,".//..//..").has_xpath?(".//img[@title='#{marker}']")
end

Then(/^the "(?:.*?)" with the name "(.*?)" does not have the "(.*?)" marker$/) do |name, marker|
  page.find_link(name).first(:xpath,".//..//..").has_no_xpath?(".//img[@title='#{marker}']")
end
