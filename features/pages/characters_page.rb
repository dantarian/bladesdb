class CharactersPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Characters"

    def check_for_character(player, character)
        unless User.first.approved_at.nil?
            page.find("tbody tr").should have_text(player.name)
            page.find("tbody tr").should have_link(character.name)
        else
            page.find("tbody tr").should have_text("AO")
            page.find("tbody tr").should have_link(character.name)
        end
    end

end