class UserCharactersPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "My Characters"

    def create_new_character(name: "Testy McTesterson", race: "Human", declared_on: Date.today, title: nil, no_title: false, guild: nil, branch: nil)
      click_link "New Character"
      fill_in("Declaration date", with: declared_on)
      page.find(".ui-dialog-titlebar").click
      fill_in("Name", with: name)
      unless title.nil?
        choose("Use a custom title")
        fill_in("character_title", with: title)
      end
      choose("Use no title") if no_title
      select(race, from: "Race")
      select(guild, from: "guild_selector") unless guild.nil?
      select(branch, from: "guild_branch_selector") unless branch.nil?
      click_button "Save Character"
    end
    
    def declare_character(name: "Testy McTesterson", race: "Human", declared_on: Date.today, title: nil, no_title: false, rank: 20, guild: nil, branch: nil, 
                          joined_rank: 0, dts: 10, money: 0, state: "Active")
      click_link "Declare Character"
      fill_in("Character Details correct as of", with: declared_on)
      page.find(".ui-dialog-titlebar").click
      fill_in("Name", with: name)
      unless title.nil?
        choose("Use a custom title")
        fill_in("character_title", with: title)
      end
      choose("Use no title") if no_title
      select(race, from: "Race")
      select(guild, from: "guild_selector") unless guild.nil?
      select(branch, from: "guild_branch_selector") unless branch.nil?
      fill_in("Character Point Total at which you joined your current guild", with: joined_rank) unless guild.nil?
      select(state, from: "State")
      fill_in("Money (in florins)", with: money)
      fill_in("Death Thresholds Remaining", with: dts)
      fill_in("Character Point Total", with: rank)
      click_button "Save Character"
    end
    

end