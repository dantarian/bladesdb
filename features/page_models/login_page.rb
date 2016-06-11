class LoginPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Sign In"

    def login_as(user)
        login_with_credentials(user.username, user.password)
    end

    def login_with_credentials(username, password)
        fill_in "Username", with: username
        fill_in "Password", with: password
        click_button "Sign in"
        HomePage.new
    end
end
