class GamePage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def publish_briefs
        accept_alert do
            accept_alert do
                click_link "Publish briefs"
            end
        end
        self
    end
    
    def finish_debrief
        click_link "Finish Debrief"
        self
    end
end
