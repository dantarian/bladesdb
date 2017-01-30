class DebriefPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Debrief"

    def add_player_to_debrief(player: nil, character: nil)
      click_link "Add Character"
      if player.nil?
        click_link "Create New User"
        fill_in("Name", with: "Lady Test")
        click_button "Create"
      else
        select(player, from: "user_selector")
        click_button "Select"
      end
      if character.nil?
        click_link "Create New Character"
        fill_in("Name", with: "Judge Test")
        click_button "Create Character"
      else
        select(character, from: "Select Character")
        click_button "Select"
      end
      click_button "Select"
    end

    def add_monster_to_debrief(monster: nil)
      click_link "Add Monster"
      if monster.nil?
        click_link "Create New User"
        fill_in("Name", with: "Lady Test")
        click_button "Create"
      else
        select(player, from: "user_selector")
        click_button "Select"
      end
      click_button "Select"
    end

    def add_gm_to_debrief(gm: nil)
      click_link "Add GM"
      if gm.nil?
        click_link "Create New User"
        fill_in("Name", with: "Lady Test")
        click_button "Create"
      else
        select(player, from: "user_selector")
        click_button "Select"
      end
      click_button "Select"
    end

    def check_for_player(player, character)
    end

    def check_for_monster(monster)
    end

    def check_for_gm(gm)
    end
end
