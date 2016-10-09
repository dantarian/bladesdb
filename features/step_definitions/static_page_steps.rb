# Set-up steps

Given(/^there is a general page$/) do
  PageTestHelper.create_page
end

Given(/^there is a members page$/) do
  PageTestHelper.create_page(show_to_non_users: false)
end

# Actions

When(/^the user views the page$/) do
  UserDefinedPage.new.visit_page(page_path(Page.all.second.id))
end

When(/^the user deletes the home page$/) do
  PagesPage.new.visit_page(pages_path).and.delete_page(Page.first)
end

When(/^the user creates a static page$/) do
  PagesPage.new.visit_page(pages_path).and.create_page
end

When(/^the user previews a static page$/) do
  PagesPage.new.visit_page(pages_path).and.preview_page
end

When(/^the user edits a static page$/) do
  PagesPage.new.visit_page(pages_path).and.edit_page(Page.all.second)
end

When(/^the user edits a static page through the page$/) do
  UserDefinedPage.new.visit_page(page_path(Page.all.second.id)).and.edit_page
end

When(/^the user deletes a static page$/) do
  PagesPage.new.visit_page(pages_path).and.delete_page(Page.all.second)
end

When(/^the user creates a static page with the same title$/) do
  PagesPage.new.visit_page(pages_path).and.create_page
end

When(/^the user creates a static page with no content$/) do
  PagesPage.new.visit_page(pages_path).and.create_page(content: "")
end

# Validations

Then(/^the home page should not be deleted$/) do
  PagesPage.new.find_page(id: 1, title: "Welcome to BathLARP")
end

Then(/^the page should be deleted$/) do
  PagesPage.new.find_page(id: 2, title: "Page", display: false)
end

Then(/^the page should be displayed$/) do
  UserDefinedPage.new.check_page_details(Page.all.second)
end

Then(/^the user should not see an edit link$/) do
  UserDefinedPage.new.check_for_links(text: "Edit", display: false)
end

Then(/^the user should see an edit link$/) do
  UserDefinedPage.new.check_for_links(text: "Edit")
end

Then(/^the new page should be displayed$/) do
  UserDefinedPage.new.check_page_details(Page.all.second)
end

Then(/^a preview of the page should be displayed$/) do
  UserDefinedPage.new.check_for_preview
end

Then(/^the updated page should be displayed$/) do
  UserDefinedPage.new.check_page_details(Page.all.second)
end
