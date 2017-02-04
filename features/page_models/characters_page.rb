class CharactersPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Characters"

    def check_for_character(player, character)
        unless User.first.approved_at.nil?
            page.find("tbody").should have_text(player.name)
            page.find("tbody").should have_link(character.name)
        else
            page.find("tbody").should have_text("AO")
            page.find("tbody").should have_link(character.name)
        end
    end
    
    def check_for_undeclared_character(player, character)
        click_link "Show all characters"
        page.find("table#gm-created tbody").should have_text(player)
        page.find("table#gm-created tbody").should have_link(character)
    end
end