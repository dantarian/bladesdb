class RegistrationPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Sign Up"

    def register_as(username, name, email, password, over18: true, accept_terms_and_conditions: true)
        fill_in "Username", with: username
        fill_in "Real name", with: name
        fill_in "E-mail address", with: email
        fill_in "Password", with: password
        fill_in "Confirm password", with: password
        page.send(over18 ? "check" : "uncheck", "I confirm I am at least 18 years old")
        page.send(accept_terms_and_conditions ? "check" : "uncheck", "I accept the Terms and Conditions") if page.has_content? "I accept the Terms and Conditions"
        click_button "Sign up"
        HomePage.new
    end

end
