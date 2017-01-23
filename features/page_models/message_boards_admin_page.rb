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
      page.find_link(name).first(:xpath,".//..").click_link("Edit")
      if !new_name.nil?
        fill_in("Name", with: name)
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

    def find_board(name: nil, ic: nil, closed: nil, deleted: nil)
    end

    def check_for_postability(name: nil, post: nil)
    end

    def check_for_position(board1, board2)
    end

end
