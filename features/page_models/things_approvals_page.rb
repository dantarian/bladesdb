class ThingsApprovalsPage < BladesDBPage
  PAGE_TITLE = BladesDBPage::PAGE_TITLE

  def approve_character_point_adjustment
    page.find(".character_point_adjustment").click_link("Approve")
  end
  
  def reject_character_point_adjustment
    page.find(".character_point_adjustment").click_link("Reject")
  end

end
