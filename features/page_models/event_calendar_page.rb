class EventCalendarPage < BladesDBPage
    include ActiveSupport
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Event Calendar"

    def start_adding_new_game
        click_link "Add game"
        self
    end

    def request_to_play(game: nil, as: nil)
        character = as || Character.first
        set_attendance(game, "Play") do |dialog|
            dialog.select(character.title_name_and_rank, from: "game_attendance_character_id")
        end
    end

    def request_to_monster(game: nil)
        set_attendance(game, "Monster")
    end

    def set_attending(game: nil)
        set_attendance(game, "Attending")
    end

    def set_not_attending(game: nil)
        set_attendance(game, "Not attending")
    end

    def set_attendance(game, state)
      game ||= Game.first
      link_text = (game.attendance_only ? "Set attendance status" : "Set playing status")

      make_details_visible(game)
      page.find("#gamedetailsrow#{game.id}").click_link link_text

      dialog = page.find("div#dialog")
      dialog.select(state, from: "state")
      yield(dialog) if block_given?
      page.click_button "Set"
      self
    end

    def make_details_visible(game)
        if page.find("tbody tr#gamedetailsrow#{game.id}", visible: :hidden)
            page.find("tbody tr#gamesummaryrow#{game.id} td.details a").click
        end
        self
    end

    def check_for_gm(gm, loggedin: true)
        if loggedin
            unless User.first.approved_at.nil?
                page.find("tbody tr#gamesummaryrow1").should have_text(gm.name)
                page.find("tbody tr#gamesummaryrow1").should have_link(gm.name)
            else
                page.find("tbody tr#gamesummaryrow1").should have_text("GM")
                page.find("tbody tr#gamesummaryrow1").should have_no_link(gm.name)
            end
        else
            page.find("tbody tr#gamesummaryrow1").should have_text("Log in to view")
            page.find("tbody tr#gamesummaryrow1").should have_no_link(gm.name)
        end
        self
    end

    def check_for_player(player, character)
        make_details_visible(Game.find.first)
        gamedetails = page.find("tbody tr#gamedetailsrow1")
        playerdetails = gamedetails.find("table.players tbody tr")

        unless User.first.approved_at.nil?
          playerdetails.should have_text(player.name)
          playerdetails.should have_link(player.name)
          playerdetails.should have_text(character.name)
          playerdetails.should have_link(character.name)
        else
          playerdetails.should have_text("PP")
          playerdetails.should have_no_link(player.name)
          playerdetails.should have_text(character.name)
          playerdetails.should have_no_link(character.name)
        end
        self
    end

    def check_for_monster(monster)
        page.find("tbody tr#gamesummaryrow1 td.details a").click
        gamedetails = page.find("tbody tr#gamedetailsrow1")
        monsterdetails = gamedetails.find("table.monsters tbody tr")

        unless User.first.approved_at.nil?
          monsterdetails.should have_text(monster.name)
          monsterdetails.should have_link(monster.name)
        else
          monsterdetails.should have_text("MM")
          monsterdetails.should have_no_link(monster.name)
        end
        self
    end

    def check_for_non_attendee(non_attendee)
        page.find("tbody tr#gamesummaryrow1 td.details a").click
        gamedetails = page.find("tbody tr#gamedetailsrow1")
        non_attendee_details = gamedetails.find("table.notattending tbody tr")

        unless User.first.approved_at.nil?
          non_attendee_details.should have_text(non_attendee.name)
          non_attendee_details.should have_no_link(non_attendee.name)
        else
          non_attendee_details.should have_text("NA")
          non_attendee_details.should have_no_link(non_attendee.name)
        end
        self
    end

    def check_for_game_visibility(game, loggedin: true)
        if loggedin
            page.should have_selector("tr#gamesummaryrow1")
            page.find("tbody tr#gamesummaryrow1 td.details").should have_selector("a")
            page.find("tbody tr#gamesummaryrow1 td.details a").click
            page.should have_selector("tr#gamedetailsrow1")
            page.should have_text(game.ic_brief)
            page.should have_text(game.ooc_brief)
        else
            page.should have_selector("tr#gamesummaryrow1")
            page.find("tbody tr#gamesummaryrow1 td.details").should have_no_selector("a")
            page.should have_no_selector("tr#gamedetailsrow1")
        end
        self
    end

    def check_new_game_date_is_next_sunday
        page.find("div#dialog").find_field('Start date').value.should eq(next_sunday.to_formatted_s)
        self
    end

    def check_new_game_date_is_sunday_after_next
        page.find("div#dialog").find_field('Start date').value.should eq((next_sunday + 7.days).to_formatted_s)
        self
    end

    def check_cannot_sign_up_to_game(game)
        game ||= Game.first
        make_details_visible(game)
        page.find("#gamedetailsrow#{game.id}").should have_no_link "Set playing status"
        self
    end

    def check_cannot_sign_up_to_attend_game(game)
        check_cannot_sign_up_as(game, "playing", "attending")
    end

    def check_cannot_sign_up_to_play_game(game)
        check_cannot_sign_up_as(game, "attendance", "playing")
    end

    def check_cannot_sign_up_to_monster_game(game)
        check_cannot_sign_up_as(game, "attendance", "monstering")
    end

    def check_cannot_sign_up_as(game, game_type, state)
        game ||= Game.first
        make_details_visible(game)
        page.find("#gamedetailsrow#{game.id}").click_link "Set #{game_type} status"
        page.find("#dialog select#state").should have_no_selector "[value='#{state}']"
        self
    end

    def check_for_character_request(game, character)
        character ||= Character.first
        check_for_attendance_status(game, ".players", should: have_text(character.title_name_and_rank))
    end

    def check_for_monster_request(game, user)
        user ||= User.first
        check_for_attendance_status(game, ".monsters", should: have_text(user.name))
    end

    def check_for_attending(game, user)
        user ||= User.first
        check_for_attendance_status(game, ".attending", should: have_text(user.name))
    end

    def check_for_not_attending(game, user)
        user ||= User.first
        check_for_attendance_status(game, ".notattending", should: have_text(user.name))
    end

    def check_for_attendance_status(game, section, should: nil)
        game ||= Game.first
        make_details_visible(game)
        page.find("#gamedetailsrow#{game.id} #{section}").should should
        self
    end

    private

        def next_sunday
            Date.today.sunday > Date.today ? Date.today.sunday : Date.today.sunday + 7.days
        end

end
