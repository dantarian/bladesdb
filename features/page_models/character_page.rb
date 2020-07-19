class CharacterPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Character Profile"

    # Action steps

    def buy_character_points_with_monster_points(character_points, date: Date.today)
        page.click_link "Spend monster points"
        set_datepicker_date("monster_point_spend_spent_on", date)
        page.click_button "Next"
        page.fill_in("Character Points to buy", :with => character_points)
        page.click_button "Spend Points"
    end

    def try_to_spend_monster_points_on(date)
        page.click_link "Spend monster points"
        set_datepicker_date("monster_point_spend_spent_on", date)
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

    def update_bio(bio)
      page.find("li#biography").click_link("Edit")
      fill_in("Biography", with: bio)
      click_button("Save")
      self
    end

    def update_date_of_birth(date_of_birth)
      page.find("li#dateof_birth").click_link("Edit")
      set_datepicker_date("character_date_of_birth", date_of_birth)
      click_button("Save")
      self
    end

    def update_address(address)
      page.find("li#address").click_link("Edit")
      fill_in("Address", with: address)
      click_button("Save")
      self
    end

    def update_notes(notes)
      page.find("li#notes").click_link("Edit")
      fill_in("Notes", with: notes)
      click_button("Save")
      self
    end

    def update_private_notes(notes)
      page.find("li#private_notes").click_link("Edit")
      fill_in("Private Notes", with: notes)
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

    def recycle_character
      accept_confirm do
        click_link("Recycle")
      end
    end

    def retire_character
      click_link("Retire")
    end

    def reactivate_character
      click_link("Reactivate")
    end

    def permkill_character
      accept_confirm do
        click_link("Perm-kill")
      end
    end

    def request_resurrection
      click_link("Request resurrection from perm-death")
    end

    def transfer_money(amount, to: nil)
      start_money_transfer
      fill_in("Amount to transfer (in florins)", with: amount)
      fill_in("Description", with: "Hush money")
      if to.respond_to?(:name_and_title)
        choose("to_character")
        select(to.name_and_title, from: "transaction_credit_attributes_character_id")
      else
        choose("to_other")
        fill_in("To other recipient", with: to)
      end
      set_datepicker_date("transaction_transaction_date", Date.today)
      click_button("Transfer")
    end

    def transfer_money_from_npc(amount)
      click_link("Transfer money to character")
      fill_in("Amount to transfer (in florins)", with: amount)
      fill_in("Description", with: "Hush money")
      choose("from_other")
      fill_in("From other source", with: "NPC")
      set_datepicker_date("transaction_transaction_date", Date.today)
      click_button("Transfer")
    end

    def start_money_transfer
      if page.has_link?("Transfer money from character")
        click_link("Transfer money from character")
      else
        click_link("Transfer money")
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

    def check_for_biography(bio)
      page.find("li#biography").should have_content(bio)
    end

    def check_for_date_of_birth(date_of_birth)
      page.find("li#dateof_birth").should have_content(date_of_birth)
    end

    def check_for_address(address)
      page.find("li#address").should have_content(address)
    end

    def check_for_notes(notes)
      page.find("li#notes").should have_content(notes)
    end

    def check_for_private_notes(private_notes)
      page.find("li#private_notes").should have_content(private_notes)
    end

    def confirm_absence_of_spend_monster_points_link
        page.find("li#rank").find("div.fieldactions").should have_no_link "Spend monster points" if page.has_selector?("li#rank")
    end

    def confirm_absence_of_recycle_link
      page.find("li#state").find("div.fieldactions").should have_no_link "Recycle" if page.has_selector?("li#state")
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

    def check_for_not_enough_money_available_message
        check_is_displaying_message(I18n.t("character.money_transfers.validation.not_enough_money", money: "10"))
    end

    def check_for_target_character_list_without_own_characters
        expect(page).to have_no_select("#transaction_credit_attributes_character_id", with_options: ["Second Character"])
    end
end
