class FirstAidReportPage < BladesDBPage
  PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "First Aid Report"
  
    def check_medical_details(user, role: "gm", updated: true)
        if role == "gm" then
          searcharea = page.find("table.gms")
        elsif role == "player" then
          searcharea = page.find("table.players")
        elsif role == "monster" then
          searcharea = page.find("table.monsters")
        end
        firstrow = "tr#user" + user.id.to_s + "firstrow"
        secondrow = "tr#user" + user.id.to_s + "secondrow"
        thirdrow = "tr#user" + user.id.to_s + "thirdrow" 
        searcharea.find(firstrow).should have_text(user.name)
        if updated then
          searcharea.find(firstrow).should have_text("Last Updated: " + Date.today.to_date.to_s)
          searcharea.find(secondrow).should have_text(user.contact_name)
          searcharea.find(secondrow).should have_text(user.contact_number)
          searcharea.find(thirdrow).should have_text(user.medical_notes)
          searcharea.find(thirdrow).should have_text(user.food_notes)
        else
          searcharea.find(firstrow).should have_text("Last Updated: Never")
          searcharea.find(secondrow).should have_text(user.name + " has no emergency contact.")
          searcharea.find(thirdrow).should have_text(user.name + " has no medical notes.")
          searcharea.find(thirdrow).should have_text(user.name + " has no food notes.")
        end
    end
    
    def check_no_user(user)
      search = "tr#user" + user.id.to_s + "firstrow"
      page.should have_no_css(search)
    end
    
end

