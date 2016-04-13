module PageTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions

  def create_page(title: "Page", content: "Page content.", show_to_non_users: true)
      Page.create title: title, content: content, show_to_non_users: show_to_non_users
  end

end
