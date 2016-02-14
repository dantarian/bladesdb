class GamePage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def self.visit_page_for(game)
        visit game_path(game)
        GamePage.new
    end

    def publish_briefs
        click_link "Publish briefs"
        self
    end
end
