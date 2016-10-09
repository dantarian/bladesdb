class CharacterProfilePage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Character Profile"
    
    # Field update steps
    
    def update_name(name)
      page.find("li#name").click_link("Edit")
      fill_in("Name", with: name)
      click_button("Save")
      self
    end
    
    def update_title(title: nil, no_title: false)
      page.find("li#name").click_link("Edit")
      unless title.nil?
        choose("Use a custom title")
        fill_in("character_title", with: title)
      end
      choose("Use no title") if no_title == true
      click_button("Save")
      self
    end
    
    def join_guild(guild, branch: nil)
      click_link("Join guild")
      select(guild, from: "guild_selector")
      select(branch, from: "guild_branch_selector") unless branch.nil?
      click_button("Change Guild")
    end
    
    def change_guild(guild, branch: nil)
      click_link("Change guild")
      select(guild, from: "guild_selector")
      select(branch, from: "guild_branch_selector") unless branch.nil?
      click_button("Change Guild")
    end
    
    def change_branch(branch)
      click_link("Change branch")
      save_and_open_page
      select(branch, from: "guild_membership_guild_branch_id")
      click_button("Change")
    end
    
    def leave_guild
      accept_confirm do
        click_link("Leave guild")
      end
    end
    
    def cancel_guild_change
      accept_confirm do
        click_link("Cancel guild change")
      end
    end
    
    # Checks for Then steps
   
    def check_for_core_fields(character_name: "Testy McTesterson", state: "Active", race: "Human", dts: 10, rank: "2.0")
      check_for_character_name(character_name)
      check_for_state(state)
      check_for_race(race)
      check_for_death_thresholds(dts)
      check_for_rank(rank)
    end
    
    def check_for_character_name(character_name)
      page.find("li#name").should have_content(character_name)
    end
    
    def check_for_character_title(title)
      if title.nil?
        page.find("li#name").should have_no_content("Wizard")
      else
        page.find("li#name").should have_content(title)
      end
    end
    
    def check_for_player_name(player_name: "Norman Normal")
      page.find("li#player_name").should have_content(player_name)
    end
    
    def check_for_state(state)
      page.find("li#state").should have_content(state)
    end
    
    def check_for_race(race)
      page.find("li#race").should have_content(race)
    end
    
    def check_for_death_thresholds(dts)
      page.find("li#death_thresholds").should have_content(dts)
    end
    
    def check_for_guild(guild, branch: nil, state: nil)
      guild_section = page.find("li#guild")
      unless branch.nil?
        guild_section.should have_content(guild)
      else
        guild_section.should have_content(guild)
        guild_section.should have_content(branch)
      end
      unless state.nil?
        if state == "join_pending"
          guild_section.should have_content("(Application to join")
          guild_section.should have_content("is pending approval.)")
        elsif state == "leave_pending"
          guild_section.should have_content("(Application to leave")
          guild_section.should have_content("is pending approval.)")
        elsif state == "change_pending"
          guild_section.should have_content("(Application to move to the")
          guild_section.should have_content("is pending approval.)")
        elsif state == "join_rejected"
          guild_section.should have_content("(Application to join")
          guild_section.should have_content("was rejected by")
        elsif state == "leave_rejected"
          guild_section.should have_content("(Application to leave")
          guild_section.should have_content("was rejected by")
        elsif state == "change_rejected"
          guild_section.should have_content("(Application to move to the")
          guild_section.should have_content("was rejected by")
        end
      end
    end
    
    def check_for_rank(rank)
      page.find("li#rank").should have_content(rank)
    end
    
    def check_for_money(money: "0g")
      page.find("li#money").should have_content(money)
    end

end