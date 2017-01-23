class MessageBoardsAdminPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Message Boards"

    def create_board(name: nil, blurb: nil, ic: false)
      click_link("Add board")
      fill_in("Name", with: name)
      fill_in("Blurb", with: blurb)
      if ic
        check("In character")
      end
      click_button("Create")
    end

    def update_board(name: nil, new_name: nil, blurb: nil, ic: nil)
      page.find_link(name).find(:xpath, "../..").click_link("Edit")
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
      click_button("Save")
    end

    def delete_board(name: nil)
      accept_confirm do
        page.find_link(name).find(:xpath, "../..").click_link("Delete")
      end
    end

    def close_board(name: nil)
      page.find_link(name).find(:xpath, "../..").click_link("Close")
    end

    def open_board(name: nil)
      page.find_link(name).find(:xpath, "../..").click_link("Open")
    end

    def move_board_up(name: nil)
      page.find_link(name).find(:xpath, "../..").find("i.fa-arrow-up").find(:xpath, "..").click
    end

    def move_board_down(name: nil)
      page.find_link(name).find(:xpath, "../..").find("i.fa-arrow-down").find(:xpath, "..").click
    end

    def find_board(name: nil, ic: false, closed: false, deleted: false)
      if deleted
        page.should_not have_css("table.openboards")
        page.should_not have_css("table.closedboards")
        page.should have_text("No boards found.")
      else
        if closed
          table = page.find_by_id("closedboards")
        else
          table = page.find_by_id("openboards")
        end
        table.should have_link(name)
        if ic
          table.find_link(name).find(:xpath, "..").should have_css("a.icboard")
        else
          table.find_link(name).find(:xpath, "..").should have_css("a.oocboard")
        end
      end
    end

    def check_for_postability(name: nil, post: nil)
      click_link(name)
      if post
        page.should have_button("Post")
      else
        page.should_not have_button("Post")
      end
    end

    def check_for_position(board1, board2)
      table = page.find_by_id("openboards")
      table.find(:css, "tr:nth-child(1)").should have_link(board1)
      table.find(:css, "tr:nth-child(2)").should have_link(board2)
    end

end
