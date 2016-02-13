class LoginPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Sign In"

    def self.visit_page
        visit new_user_session_path
        LoginPage.new
    end

    def login_as(user)
        login_with_credentials(user.username, user.password)
    end

    def login_with_credentials(username, password)
        fill_in "Username", with: @user.username
        fill_in "Password", with: @user.password
        click_button "Sign in"
        HomePage.new
    end
end
