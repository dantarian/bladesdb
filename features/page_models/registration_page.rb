class RegistrationPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Sign Up"

    def register_as(username, name, email, password, over18: true)
        fill_in "Username", with: username
        fill_in "Real name", with: name
        fill_in "E-mail address", with: email
        fill_in "Password", with: password
        fill_in "Confirm password", with: password
        if over18
          check "I confirm I am at least 18 years old"
        else
          uncheck "I confirm I am at least 18 years old"
        end
        click_button "Sign up"
        HomePage.new
    end

end
