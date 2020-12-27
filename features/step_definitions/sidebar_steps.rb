Given("there is a sidebar category") do
    SidebarTestHelper.create_category
end

Given("there are three sidebar categories") do
    SidebarTestHelper.create_category(name: "First Category")
    SidebarTestHelper.create_category(name: "Second Category")
    SidebarTestHelper.create_category(name: "Third Category")
end

Given("there is a page in the sidebar category") do
    SidebarTestHelper.create_entry(category: SidebarCategory.first)
end

Given("there are three pages in the sidebar category") do
    SidebarTestHelper.create_entry(category: SidebarCategory.first, name: "First Page")
    SidebarTestHelper.create_entry(category: SidebarCategory.first, name: "Second Page")
    SidebarTestHelper.create_entry(category: SidebarCategory.first, name: "Third Page")
end

When("the user adds a sidebar category") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.add_category('Test Category')
end

When("the user removes the sidebar category") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.remove_category(SidebarCategory.last.id)
end

When("the user moves the first category down") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.move_category_down(SidebarCategory.first.id)
end

When("the user moves the last category up") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.move_category_up(SidebarCategory.last.id)
end

When("the user adds the page to the sidebar category") do
    SidebarPage.new
               .visit_page(edit_sidebar_path)
               .add_page_to_category(category_id: SidebarCategory.last.id, title: Page.last.title, name: "Test Page")
end

When("the user clicks on the page in the sidebar") do
    SidebarPage.new
               .visit_page(edit_sidebar_path)
               .expand_sidebar_category(SidebarCategory.last.name)
               .click_sidebar_link(SidebarEntry.last.name)
end

When("the user adds the home page to the sidebar category") do
    SidebarPage.new
               .visit_page(edit_sidebar_path)
               .add_url_to_category(category_id: SidebarCategory.last.id, url: "/", name: "Test Page")
end

When("the user removes the page from the sidebar category") do
    SidebarPage.new
               .visit_page(edit_sidebar_path)
               .remove_entry_from_category(category_id: SidebarCategory.last.id,
                                           entry_id: SidebarEntry.last.id)
end

When("the user moves the first page down") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.move_entry_down(SidebarEntry.first.id)
end

When("the user moves the third page up") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.move_entry_up(SidebarEntry.last.id)
end

Then("the category should appear in the sidebar") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.check_for_category('Test Category')
end

Then("the category should not appear in the sidebar") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.check_for_no_category('Test Category')
end

Then("the second category should be first") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.check_category_position('Second Category', 1)
end

Then("the third category should be second") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.check_category_position('Third Category', 2)
end

Then("the fist category should be last") do
    SidebarPage.new.visit_page(edit_sidebar_path).and.check_category_position('First Category', 3)
end

Then("the page should appear under the category in the sidebar") do
    SidebarPage.new
               .visit_page(edit_sidebar_path)
               .check_for_entry_in_category(category_id: SidebarCategory.last.id,
                                            name: "Test Page")
end

Then("the page should not appear under the the category in the sidebar") do
    SidebarPage.new
               .visit_page(edit_sidebar_path)
               .check_for_no_entry_in_category(category_id: SidebarCategory.last.id,
                                               name: "Test Page")
end

Then("the second page should be first") do
    SidebarPage.new
               .visit_page(edit_sidebar_path)
               .check_entry_position_in_category(SidebarCategory.last.id, 'Second Page', 1)
end

Then("the third page should be second") do
    SidebarPage.new
               .visit_page(edit_sidebar_path)
               .check_entry_position_in_category(SidebarCategory.last.id, 'Third Page', 2)
end

Then("the first page should be last") do
    SidebarPage.new
               .visit_page(edit_sidebar_path)
               .check_entry_position_in_category(SidebarCategory.last.id, 'First Page', 3)
end