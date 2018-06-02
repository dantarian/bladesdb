class TermsAndConditionsPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def accept
      click_on "Accept"
    end

    def reject
      click_on "Reject"
    end

    def confirm_reject
      click_on "Reject and suspend my account"
    end

end
