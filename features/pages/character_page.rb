class CharacterPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def buy_character_points_with_monster_points(character_points, on_date: Date.today)
        click_link "Spend monster points"
        fill_in "Spent on", with: on_date.to_formatted_s
        click_on "Next"
        fill_in "Character Points to purchase", with: character_points
        click_on "Spend Points"
    end
    
    def try_to_spend_monster_points_on(date)
        click_link "Spend monster points"
        fill_in "Spent on", with: date.to_formatted_s
        click_on "Next"
    end

    # Validations

    def check_character_points(points)
        page.find("#rank").find(".fieldvalue").should have_text(points.to_f / 10.0)
    end

    def check_for_not_enough_monster_points_available_message(points)
        check_is_displaying_message I18n.t("character.monster_points.not_enough_mp", points: points)
    end
    
    def check_for_too_many_points_bought_message(points)
        check_is_displaying_message I18n.t("character.monster_points.too_many_cp", points: points)
    end
    
    def check_for_cannot_buy_less_than_one_point_message
        check_is_displaying_message I18n.t("character.monster_points.at_least_one")
    end
    
    def check_for_cannot_spend_before_last_spend_message(date)
        check_is_displaying_message I18n.t("character.monster_points.not_before_last_spend", date: date)
    end
    
    def check_for_cannot_spend_before_penultimate_game_message(date)
        check_is_displaying_message I18n.t("character.monster_points.not_before_penultimate_game", date: date)
    end
    
    def check_for_not_before_monster_point_declaration_message(date)
        check_is_displaying_message I18n.t("character.monster_points.not_before_monster_point_declaration", date: date)
    end
    
    def check_for_not_before_character_declaration_message(date)
        check_is_displaying_message I18n.t("character.monster_points.not_before_character_declaration", date: date)
    end
    
    def check_for_cannot_spend_in_future_message
        check_is_displaying_message I18n.t("character.monster_points.not_in_future")
    end
end