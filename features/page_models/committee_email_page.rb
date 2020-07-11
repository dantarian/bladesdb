class CommitteeEmailPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def send_message(type:, subject: "Subject", message: "Message content")
        choose type
        fill_in "Subject", with: subject
        fill_in "Message", with: message
        click_on "Send email"
    end
end
