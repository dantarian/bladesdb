class CharacterPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Character Profile"

    # Action steps

    def buy_character_points_with_monster_points(character_points, date: Date.today)
        page.click_link "Spend monster points"
        page.fill_in("Spent on", :with => date.strftime())
        page.click_button "Next"
        page.fill_in("Character Points to buy", :with => character_points)
        page.click_button "Spend Points"
    end

    def try_to_spend_monster_points_on(date)
        page.click_link "Spend monster points"
        page.fill_in("Spent on", :with => date.strftime())
        page.click_button "Next"
    end

    def delete_last_monster_point_spend
        page.click_link "Delete last monster point spend"
    end

    def try_to_delete_last_monster_point_spend(url)
        page.driver.submit :delete, url, {}
    end

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

    def confirm_absence_of_spend_monster_points_link
        page.find("li#rank").find("div.fieldactions").should have_no_link "Spend monster points" if page.has_selector?("li#rank")
    end

    def check_no_monster_point_spend
        page.should have_no_content("Monster Points Spent")
    end

    def check_mp_spend_link_alternative_message(message)
        page.find("li#rank").find("span.no_mp_spend_reason").should have_content(message)
    end

    def check_character_points(points)
        page.find("li#rank").find("span.fieldvalue").should have_content((points/10.0).to_s)
    end

    def check_for_not_enough_monster_points_available_message(points)
        check_error_message(I18n.t("character.monster_points.not_enough_mp", points: points))
    end

    def check_for_too_many_points_bought_message(points)
        check_error_message(I18n.t("character.monster_points.too_many_cp", points: points))
    end

    def check_for_cannot_buy_less_than_one_point_message
        check_error_message(I18n.t("character.monster_points.at_least_one"))
    end

    def check_for_cannot_buy_negative_character_points_message
        check_error_message(I18n.t("character.monster_points.at_least_one"))
    end

    def check_for_cannot_spend_before_last_spend_message(date)
        check_error_message(I18n.t("character.monster_points.not_before_last_spend", date: date))
    end

    def check_for_cannot_spend_before_most_recent_debriefed_game_message(date)
        check_error_message(I18n.t("character.monster_points.not_before_most_recent_debrief", date: date))
    end

    def check_for_cannot_spend_before_monster_point_declaration_message(date)
        check_error_message(I18n.t("character.monster_points.not_before_monster_point_declaration", date: date))
    end

    def check_for_cannot_spend_before_character_declaration_message(date)
        check_error_message(I18n.t("character.monster_points.not_before_character_declaration", date: date))
    end

    def check_for_cannot_spend_before_character_point_adjustment(date)
        check_error_message(I18n.t("character.monster_points.not_before_character_point_adjustment", date: date))
    end

    def check_for_cannot_spend_in_future_message
        check_error_message(I18n.t("character.monster_points.not_in_future"))
    end

    def check_for_cannot_spend_on_unapproved_character_message
        check_mp_spend_link_alternative_message(I18n.t("character.monster_points.not_on_unapproved_character"))
    end

    def check_for_cannot_spend_on_retired_character_message
        check_mp_spend_link_alternative_message(I18n.t("character.monster_points.not_on_retired_character"))
    end

    def check_for_cannot_spend_on_dead_character_message
        check_mp_spend_link_alternative_message(I18n.t("character.monster_points.not_on_dead_character"))
    end

    def check_for_cannot_spend_on_recycled_character_message
        check_mp_spend_link_alternative_message(I18n.t("character.monster_points.not_on_recycled_character"))
    end

    def check_for_cannot_spend_on_undeclared_character_message
        check_mp_spend_link_alternative_message(I18n.t("character.monster_points.not_on_undeclared_character"))
    end

    def check_for_cannot_delete_spend_before_debriefed_game_message(date)
        check_error_message(I18n.t("character.monster_points.delete_last_spend.not_with_closed_debrief_after", date: date))
    end

    def check_for_cannot_delete_spend_before_monster_point_declaration(date)
        check_error_message(I18n.t("character.monster_points.delete_last_spend.not_with_mp_declaration_after", date: date))
    end

    def check_for_cannot_delete_spend_before_monster_point_adjustment(date)
        check_error_message(I18n.t("character.monster_points.delete_last_spend.not_with_mp_adjustment_after", date: date))
    end

    def check_for_cannot_delete_spend_before_character_point_adjustment(date)
        check_error_message(I18n.t("character.monster_points.delete_last_spend.not_with_cp_adjustment_after", date: date))
    end

    def check_for_cannot_delete_spend_on_dead_character
        check_error_message(I18n.t("character.monster_points.delete_last_spend.not_when_perm_dead"))
    end

    def check_for_cannot_delete_spend_on_retired_character
        check_error_message(I18n.t("character.monster_points.delete_last_spend.not_when_retired"))
    end

    def check_for_cannot_delete_spend_on_recycled_character
        check_error_message(I18n.t("character.monster_points.delete_last_spend.not_when_recycled"))
    end
end
