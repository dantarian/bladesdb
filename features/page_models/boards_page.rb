class BoardsPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def check_for_unread_messages(count, ic_board: false)
        selector = ic_board ? ".icboard" : ".oocboard"
        page.first(selector).find(:xpath, "../..").find("td:last-of-type").should have_text(count.to_s)
    end

end
