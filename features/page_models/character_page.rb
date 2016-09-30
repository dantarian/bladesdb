class CharacterPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def buy_character_points_with_monster_points(character_points, date: Date.today)
        page.click_link "Spend monster points"
        page.fill_in("Spent on", :with => date.strftime())
        page.click_button "Next"
        page.fill_in("Character Points to buy", :with => character_points)
        page.click_button "Spend Points"
    end

    def try_to_spend_monster_points_on(date)
        pending
    end

    def delete_last_monster_point_spend
        page.click_link "Delete last monster points spend"
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
    
    def check_for_cannot_spend_in_future_message
        check_error_message(I18n.t("character.monster_points.not_in_future"))
    end
    
    def check_for_cannot_spend_to_over_rank_message(game)
        check_error_message(I18n.t("character.monster_points.not_over_rank", title: game.title, date: game.start_date, max_rank: game.upper_rank / 10.0))
    end
end