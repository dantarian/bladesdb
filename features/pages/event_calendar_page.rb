class EventCalendarPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Event Calendar"
    
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
    end
    
    def check_for_player(player, character)
        page.find("tbody tr#gamesummaryrow1 td.details a").click
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
    end

end