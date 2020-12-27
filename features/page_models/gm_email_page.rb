class GMEmailPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def send_message(type:, subject: "Subject", message: "Message content")
        choose type
        fill_in "Subject", with: subject
        fill_in "Message", with: message
        click_on "Send email"
    end

    def send_message_including_character_refs(type:, subject: "Subject", message: "Message content")
        check "Include the Character Refs?"
        send_message(type: type, subject: subject, message: message)
    end

    def send_message_including_committee(type:, subject: "Subject", message: "Message content")
        check "Include the Committee?"
        send_message(type: type, subject: subject, message: message)
    end
end
