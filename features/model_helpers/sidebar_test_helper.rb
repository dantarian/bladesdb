module SidebarTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions

  def create_category(name: "Test Category")
    SidebarCategory.create!(name: name, order: SidebarCategory.next_order)
  end
  
  def create_entry(category:, name: "Test Page")
    category.sidebar_entries.create!(name: name, url: "/", order: category.next_entry_order)
  end
end
