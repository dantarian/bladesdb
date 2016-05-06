class MonsterPointsPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE + BladesDBPage::PAGE_TITLE_CONNECTOR + "Monster Points"

    def check_for_declaration(points, display: true)
      row = page.find("tr", :text => 'Monster Points Declared')
      if display
        row.find("td.points").should have_text(points.to_s)
      else
        row.find("td.points").should have_no_text(points.to_s)
      end
    end
    
    def check_for_adjustment(points, display: true)
      row = page.find("tr", :text => 'Adjustment: ')
      if display
        row.find("td.points").should have_text(points.to_s)
      else
        row.find("td.points").should have_no_text(points.to_s)
      end
    end

end