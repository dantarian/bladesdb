class RegistrationUpdatePage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Change Password"

    def change_password(password, confirm)
        fill_in("Current password", with: UserTestHelper::DEFAULT_PASSWORD)
        fill_in("New password", with: password)
        fill_in("Password confirmation", with: confirm)
        click_button("Update")
        ProfilePage.new
    end
    
end
