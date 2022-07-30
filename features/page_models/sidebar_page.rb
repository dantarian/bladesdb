class SidebarPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def add_category(name)
        page.click_link('Add category')
        page.fill_in('Name', with: name)
        page.click_button('Save')
        page.should have_no_content('.ui-dialog')
        self
    end

    def remove_category(id)
        accept_confirm do
            page.find("#category#{id}").click_link('Delete')
        end
        self
    end

    def move_category_up(id)
        page.find("#category#{id}").find("img[alt='Move up']").click
        self
    end

    def move_category_down(id)
        page.find("#category#{id}").find("img[alt='Move down']").click
        self
    end

    def add_page_to_category(category_id:, title:, name:)
        page.find("#category#{category_id}").click_link('Add entry')
        page.fill_in('Name', with: name)
        page.select(title, from: 'Static Page')
        page.click_button('Save')
        page.should have_no_content('.ui-dialog')
        self
    end

    def add_url_to_category(category_id:, url:, name:)
        page.find("#category#{category_id}").click_link('Add entry')
        page.fill_in('Name', with: name)
        page.fill_in('URL', with: url)
        page.click_button('Save')
        page.should have_no_content('.ui-dialog')
        self
    end

    def remove_entry_from_category(category_id:, entry_id:)
        accept_confirm do
            page.find("#category#{category_id}_and_entries")
                .find("#entry#{entry_id}_and_subentries")
                .click_link('Delete')
        end
        self
    end

    def move_entry_up(id)
        page.find("#entry#{id}_and_subentries").find("img[alt='Move up']").click
        self
    end

    def move_entry_down(id)
        page.find("#entry#{id}_and_subentries").find("img[alt='Move down']").click
        self
    end

    def expand_sidebar_category(name)
        page.find('#menu').find("a", text: name).ancestor("li").hover()
        self
    end

    def click_sidebar_link(name)
        page.find('#menu').find("a", text: name, visible: false).trigger(:click)
        sleep 0.1
        self
    end

    def check_for_category(name)
        page.find('#content-space').should have_text(name)
        self
    end

    def check_for_no_category(name)
        page.find('#content-space').should have_no_text(name)
        self
    end

    def check_category_position(name, position)
        page.find("#all_categories > div:nth-child(#{position})").should have_text(name)
        self
    end

    def check_for_entry_in_category(category_id:, name:)
        page.find('#content-space')
            .find("#category#{category_id}_and_entries").should have_text(name)
        self
    end

    def check_for_no_entry_in_category(category_id:, name:)
        page.find('#content-space')
            .find("#category#{category_id}_and_entries").should have_no_text(name)
        self
    end

    def check_entry_position_in_category(category_id, name, position)
        page.find("#category#{category_id}_and_entries .entries > div:nth-child(#{position})").should have_text(name)
        self
    end

end
