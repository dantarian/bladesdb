class MonsterPointsPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Monster Points"

    def declare_monster_points(date, points)
      click_link "Declare Monster Points"
      fill_in "Declared on", with: date.to_formatted_s
      fill_in "Points", with: points
      page.find("span.ui-dialog-title").click
      click_button "Declare"
    end

    def edit_declaration(date, points)
      click_link "Update"
      fill_in "Declared on", with: date.to_formatted_s
      fill_in "Points", with: points
      page.find("span.ui-dialog-title").click
      click_button "Update"
    end

    def request_adjustment(date, points, reason)
      click_link "Request Monster Points Adjustment"
      fill_in "Declared on", with: date.to_formatted_s
      fill_in I18n.t("user.monster_point_adjustment.points_label"), with: points
      fill_in "Reason", with: reason
      page.find("span.ui-dialog-title").click
      sleep(1)
      click_button "Request"
    end

    def check_for_declaration(points, display: true, state: "approved")
      page.should have_css("tr.provisional") if state == "provisional"
      page.should have_css("tr.rejected") if state == "rejected"
      row = page.find("tr", :text => 'Monster Points Declared')
      if display
        row.find("td.points").should have_text(points.to_s)
      else
        row.find("td.points").should have_no_text(points.to_s)
      end
    end

    def check_for_adjustment(points, display: true, state: "approved")
      page.should have_css("tr.provisional") if state == "provisional"
      page.should have_css("tr.rejected") if state == "rejected"
      row = page.find("tr", :text => 'Adjustment: ')
      if display
        row.find("td.points").should have_text(points.to_s)
      else
        row.find("td.points").should have_no_text(points.to_s)
      end
    end

    def check_for_monster_points(points)
      page.find("div#sessionpanel").should have_text("You have " + points.to_s + " monster points.")
      page.find("p#total").should have_text("Current total: " + points.to_s)
    end
end
