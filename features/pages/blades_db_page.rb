class BladesDBPage
    include Capybara::DSL
    include RSpec::Matchers
    PAGE_TITLE = "BathLARP"
    PAGE_TITLE_CONNECTOR = " - "

    def visit_page(url)
        visit url
        self
    end
    
    def and
        self
    end
    
    def check_is_displaying_message(message)
        page.should have_content(message)
    end
    
    def check_for_edit_links(display: true)
        if display
          page.should have_link("Edit")
        else
          page.should have_no_link("Edit")
        end
    end
  
    def check_monster_points(points)
      page.find("span#current_monster_points").should have_text(points.to_s)
    end
end

