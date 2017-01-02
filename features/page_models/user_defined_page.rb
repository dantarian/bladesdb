class UserDefinedPage < BladesDBPage
  
    def edit_page(title: "Edited Page", content: "Edited page content.", show_to_non_users: true)
      click_link "Edit"
      fill_in "Page title:", :with => title
      fill_in "Page content:", :with => content
      if show_to_non_users then
        check "Allow non-users to view this page"
      else
        uncheck "Allow non-users to view this page"
      end
      click_button "Save"
  end
    
    def check_page_details(static_page)
        page.find("h1").should have_text(static_page.title)
        page.should have_text(static_page.content)
    end
    
    def check_for_preview(title: "Page", content: "Page content.")
        page.find("div.preview h2").should have_text("Preview")
        page.find("div.preview h1").should have_text(title)
        page.find("div.preview").should have_text(content) 
    end
    
end

