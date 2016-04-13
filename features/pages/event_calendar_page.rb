class EventCalendarPage < BladesDBPage
    include ActiveSupport
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def start_adding_new_game
        click_link "Add game"
        self
    end
    
    def check_new_game_date_is_next_sunday
        page.find("div#dialog").find_field('Start date').value.should eq(next_sunday.to_formatted_s)
        self
    end
    
    def check_new_game_date_is_sunday_after_next
        page.find("div#dialog").find_field('Start date').value.should eq((next_sunday + 7.days).to_formatted_s)
        self
    end

    private
    
        def next_sunday
            Date.today.sunday > Date.today ? Date.today.sunday : Date.today.sunday + 7.days
        end

end
