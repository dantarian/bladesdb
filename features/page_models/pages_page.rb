class PagesPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Static Pages"

  def create_page(title: "Page", content: "Page content.", show_to_non_users: true)
      click_link "Add page"
      fill_in "Page title:", :with => title
      fill_in "Page content:", :with => content
      if show_to_non_users then
        check "Allow non-users to view this page"
      else
        uncheck "Allow non-users to view this page"
      end
      click_button "Save"
  end

  def preview_page(title: "Page", content: "Page content.", show_to_non_users: true)
      click_link "Add page"
      fill_in "Page title:", :with => title
      fill_in "Page content:", :with => content
      if show_to_non_users then
        check "Allow non-users to view this page"
      else
        uncheck "Allow non-users to view this page"
      end
      click_button "Preview"
  end

  def edit_page(static_page, title: "Edited Page", content: "Edited page content.", show_to_non_users: true)
      search = "tr#page" + static_page.id.to_s
      page.find(search).click_link "Edit"
      fill_in "Page title:", :with => title
      fill_in "Page content:", :with => content
      if show_to_non_users then
        check "Allow non-users to view this page"
      else
        uncheck "Allow non-users to view this page"
      end
      click_button "Save"
  end

  def delete_page(static_page)
      search = "tr#page" + static_page.id.to_s
      accept_confirm do
        page.find(search).click_link "Destroy"
      end
  end

  def find_page(id:, title:, display: true)
    search = "tr#page" + id.to_s
    if display
      page.find(search).should have_text(title)
    else
      page.should_not have_css(search)
    end
  end
end
