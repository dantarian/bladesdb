class BoardPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def post_message(from: nil, containing_text: nil)
        if from
            if from.respond_to?(:name_and_title)
                choose("Character")
                select(from.name_and_title, from: "message_character_id")
            else
                choose("NPC Name or Scenery Description")
                fill_in("message_name", with: from.to_s)
            end
        end
        if containing_text
            fill_in("Post message", with: containing_text)
        end
        click_on("Post")
        self
    end

    def check_for_message(from: nil, id: 1, containing_text: nil, containing_link: nil, relating_to_game: nil)
        search = "div#message" + id.to_s
        message_div = page.find(search)
        if from
            unless User.first.approved_at.nil?
                if from.respond_to?(:name_and_title)
                    message_div.find("p.attrib").should have_link(from.name_and_title)
                elsif from.respond_to?(:name)
                    message_div.find("p.attrib").should have_link(from.name)
                else
                    message_div.find("p.attrib").should have_link(from.to_s)
                end
            else
                message_div.find("p.attrib").should have_no_link(from.name)
                message_div.find("p.attrib").should have_text("AO")
            end
        end
        if containing_text
            message_div.find("div.messagebody").should have_text(containing_text)
        end
        if containing_link
            message_div.find("div.messagebody").should have_link(relating_to_game.title, :href => containing_link)
        end
        self
    end

end
