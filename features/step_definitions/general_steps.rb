Then(/^the test takes a screendump$/) do
  page.save_and_open_page
end

Then(/^the test takes a screenshot$/) do
  page.save_screenshot
end
