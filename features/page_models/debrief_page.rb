class DebriefPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Debrief"

    # Interaction methods

    def add_player_to_debrief(player: nil, character: nil)
      click_link "Add Character"
      if player.nil?
        click_link "Create New User"
        fill_in("Name", with: "Lady Test")
        click_button "Create"
      else
        select(player, from: "debrief_user_id")
        click_button "Select"
      end
      if character.nil?
        click_link "Create New Character"
        fill_in("Name", with: "Judge Test")
        click_button "Create Character"
      else
        select(character, from: "debrief_character_id")
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
        select(player, from: "debrief_user_id")
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
        select(player, from: "debrief_user_id")
        click_button "Select"
      end
      click_button "Select"
    end

    def finish_debrief
      click_link "Finish Debrief"
      self
    end

    def reopen_debrief
      click_link "Reopen Debrief"
      self
    end

    def update_player_debrief(game, character, bonus: nil)
      page.find("ul.players li#game#{game.id}character#{character.id}").click_link("Edit")
      unless bonus.nil?
        page.fill_in("Bonus Points", with: bonus)
      end
      page.click_button("Update")
    end

    # Validation methods

    def check_for_player(game, player, character, displayed: true)
      if displayed then
        page.find("ul.players li#game#{game.id}character#{character.id}").should have_text(player.name)
        page.find("ul.players li#game#{game.id}character#{character.id}").should have_text(character.name)
      else
        page.should_not have_text(player)
        page.should_not have_text(character)
      end
    end

    def check_for_monster(game, monster, displayed: true)
      if displayed then
        page.find("ul.monsters li#game#{game.id}monster#{monster.id}").should have_text(monster.name)
      else
        page.should_not have_text(monster)
      end
    end

    def check_for_gm(game, gm, displayed: true)
      if displayed then
        page.find("ul.gms li#game#{game.id}gm#{gm.id}").should have_text(gm.name)
      else
        page.should_not have_text(gm)
      end
    end
end
