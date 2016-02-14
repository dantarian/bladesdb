class BoardPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def self.visit_page_for(board)
        visit board_path(board)
        BoardPage.new
    end

    def check_for_message(opts)
        message_div = page.find("div.message")
        if opts[:from]
            message_div.find("p.attrib").find("a").should have_content(opts[:from].name)
        end
        if opts[:containing_text]
            message_div.find("div.messagebody").should have_content(opts[:containing_text])
        end
        if opts[:containing_link_to_game]
            message_div.find("div.messagebody").should have_link(opts[:containing_link_to_game].title, :href => game_path(opts[:containing_link_to_game]))
        end
    end
end
