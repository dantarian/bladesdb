class ProfilePage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Profile"
    
    # Field update steps
    
    def change_password(password, confirm)
      page.click_link("Change password")
      RegistrationUpdatePage.new.and.change_password(password, confirm)
    end
    
    def update_name(name)
      page.find("li#name").click_link("Edit")
      fill_in("Name", with: name)
      find_button("Save").click
      self
    end
    
    def update_login(login)
      page.find("li#login").click_link("Edit")
      fill_in("Login", with: login)
      find_button("Save").click
      self
    end
    
    def update_email(email)
      page.find("li#email").click_link("Edit")
      fill_in("Email", with: email)
      find_button("Save").click
      self
    end
    
    def update_contact(contact)
      page.find("li#mobile_number").click_link("Edit")
      fill_in("Mobile Number", with: contact)
      find_button("Save").click
      self
    end
    
    def update_emergency_contact(name, number)
      page.find("li#emergency_contact").click_link("Edit")
      fill_in("Contact Name", with: name)
      fill_in("Contact Number", with: number)
      find_button("Save").click
      self
    end
    
    def update_medical_notes(notes)
      page.find("li#medical_notes").click_link("Edit")
      fill_in("Medical Notes", with: notes)
      find_button("Save").click
      self
    end
    
    def update_food_notes(notes)
      page.find("li#food_notes").click_link("Edit")
      fill_in("Food Notes", with: notes)
      find_button("Save").click
      self
    end
    
    def update_notes(notes)
      page.find("li#general_notes").click_link("Edit")
      fill_in("Notes", with: notes)
      find_button("Save").click
      self
    end
    
    # Checks for Then steps
   
    def check_for_core_fields(user)
      check_for_name(user)
      check_for_email(user)
      check_for_notes(user)
      check_for_statistics(user)
      page.should have_selector("li#joined_date")
      page.should have_selector("li#roles")
    end
    
    def check_for_medical_fields(user)
      check_for_emergency_contact(user)
      check_for_medical_notes(user)
      page.should have_selector("li#medical_last_updated")
    end
    
    def check_for_login(user)
      page.should have_selector("li#login")
      page.find("li#login").should have_content(user.username)
    end
    
    def check_for_contact(user)
      page.should have_selector("li#mobile_number")
      page.find("li#mobile_number").should have_content(user.mobile_number)
    end
    
    def check_for_food(user)
      page.should have_selector("li#food_notes")
      page.find("li#food_notes").should have_content(user.food_notes)
      
    end
    
    def check_for_debrief_comments
      page.should have_selector("div#last_ten_debrief_comments")
    end
    
    def check_for_name(user)
      page.should have_selector("li#name")
      page.find("li#name").should have_content(user.name)
    end
    
    def check_for_email(user)
      page.should have_selector("li#email")
      page.find("li#email").should have_content(user.email)
    end
    
    def check_for_notes(user)
      page.should have_selector("li#general_notes")
      page.find("li#general_notes").should have_content(user.notes)
    end
    
    def check_for_emergency_contact(user)
      page.should have_selector("li#emergency_contact")
      page.find("li#emergency_contact").should have_content(user.contact_name)
      page.find("li#emergency_contact").should have_content(user.contact_number)
    end
    
    def check_for_medical_notes(user)
      page.should have_selector("li#medical_notes")
      page.find("li#medical_notes").should have_content(user.medical_notes)
      page.should have_selector("li#medical_last_updated")
    end
    
    def check_for_statistics(user)
      page.should have_selector("div#statistics")
      page.find("div#statistics").should have_text("Games Played")
      page.find("div#statistics").should have_text("Games Monstered (GMed)")
    end
end