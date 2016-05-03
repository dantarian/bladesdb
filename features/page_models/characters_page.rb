class CharactersPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Characters"

    def check_for_character(player, character)
        search = "tbody tr#character" + character.id.to_s
        unless User.first.approved_at.nil?
            page.find(search).should have_text(player.name)
            page.find(search).should have_link(character.name)
        else
            page.find(search).should have_text("AO")
            page.find(search).should have_link(character.name)
        end
    end

end