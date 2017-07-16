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

    def log_out
      page.click_link("Log out")
    end

    ##
    # Sets the date on a datepicker field, bypassing any protections provided by the UI.
    def set_datepicker_date(id, date)
      page.find("##{id}").send_keys '\t'
      execute_script("$('##{id}').val('#{date.to_formatted_s}')")
    end

    def check_is_displaying_message(message)
        page.should have_content(message)
    end

    def check_for_links(text:, display: true)
        if display
          page.should have_link(text)
        else
          page.should have_no_link(text)
        end
    end

    def check_for_table(table:, display: true)
        css = 'table#' + table
        if display
          page.should have_css(css)
        else
          page.should have_no_css(css)
        end
    end

    def check_pm_ratio(user)
        page.should have_selector("div#sessionpanel")
        page.find("div#sessionpanel").should have_text("Your current P:M ratio is")
    end

    def check_monster_points(points)
        page.should have_selector("span#current_monster_points")
        page.find("span#current_monster_points").should have_text("#{points}")
    end

    def check_error_message(message)
        page.find("div.errorExplanation, div.error").should have_text(message)
    end
end
