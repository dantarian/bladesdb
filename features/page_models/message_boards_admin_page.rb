class MessageBoardsAdminPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Message Boards"

    def create_board(name: nil, blurb: nil, ic: false)
      click_link("Add board")
      fill_in("Name", with: name)
      fill_in("Blurb", with: blurb)
      if ic
        check("In character")
      end
    end

    def update_board(name: nil, new_name: nil, blurb: nil, ic: nil)
      page.find_link(name).find(:xpath, "..").click_link("Edit")
      if !new_name.nil?
        fill_in("Name", with: new_name)
      end
      if !blurb.nil?
        fill_in("Blurb", with: blurb)
      end
      if !ic.nil?
        if ic
          check("In character")
        else
          uncheck("In character")
        end
      end
    end

    def delete_board(id: nil)
    end

    def close_board(id: nil)
    end

    def open_board(id: nil)
    end

    def move_board_up(id: nil)
    end

    def move_board_down(id: nil)
    end

    def find_board(name: nil, ic: false, closed: false, deleted: false)
      if closed
        table = page.find_by_id("closedboards").find("tr")
      else
        table = page.find_by_id("openboards").find("tr")
      end
      if deleted
        table.should_not have_link(name)
      else
        table.should have_link(name)
        if ic
          table.find_link(name).should have_css(".icboard")
        else
          table.find_link(name).should have_css(".oocboard")
        end
      end
    end

    def check_for_postability(name: nil, post: nil)
    end

    def check_for_position(board1, board2)
    end

end
