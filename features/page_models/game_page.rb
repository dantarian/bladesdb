class GamePage < BladesDBPage
  PAGE_TITLE = BladesDBPage::PAGE_TITLE

  # Interaction methods

  def publish_briefs
    accept_alert do
      accept_alert do
        click_link "Publish briefs"
      end
    end
    self
  end

  def open_first_aid_report
    click_link "First Aid Report"
    self
  end

  def start_debrief(player_base: 10, monster_base: 5, danger_pay: 10)
    click_link "Debrief"
    fill_in("Player Points", with: player_base)
    fill_in("Monster Points", with: monster_base)
    fill_in("Danger Pay (florins)", with: danger_pay)
    click_button "Start Debrief"
  end

  def apply_for_game
    click_link "Apply to run"
    fill_in "Please enter any supporting details for your application.", with: "This is a game."
    click_button "Apply"
  end

  def edit_game_application
    click_link "Edit application"
    fill_in "Please enter any supporting details for your application.", with: "This is a modified game."
    click_button "Update"
  end

  def withdraw_game_application
    page.accept_confirm do
      click_link "Withdraw application"
    end
  end

  # Validation methods

  def check_for_application(from: nil, containing_text: "This is a game.")
    page.click_link("View applications")
    page.should have_text(from.name)
    page.should have_text(containing_text)
  end

  def check_no_application(from: nil)
    page.should have_no_link "View applications"
  end

  def check_for_gm(gm, display: true)
    if display then
      page.find("p#gms").should have_text(gm.name)
    else
      page.find("p#gms").should have_no_text(gm.name)
    end
  end

  def check_for_player(player, character, display: true)
    playerdetails = page.find("table.players tbody tr")

    if display then
      playerdetails.should have_text(player.name)
      playerdetails.should have_text(character.name)
    else
      playerdetails.should have_no_text(player.name)
      playerdetails.should have_no_text(character.name)
    end
  end

  def check_for_monster(monster, display: true)
    if display then
      page.find("table.monsters tbody tr").should have_text(monster.name)
    else
      page.find("table.monsters tbody tr").should have_no_text(monster.name)
    end
  end

  def check_for_attendee(attendee, display: true)
    if display then
      page.find("table.attending tbody tr").should have_text(non_attendee.name)
    else
      page.find("table.attending tbody tr").should have_no_text(non_attendee.name)
    end
  end

  def check_for_non_attendee(non_attendee, display: true)
    if display then
      page.find("table.notattending tbody tr").should have_text(non_attendee.name)
    else
      page.find("table.notattending tbody tr").should have_no_text(non_attendee.name)
    end
  end

  def check_no_apply_for_game_link
    page.should have_no_link "Apply for game"
  end

  def check_can_start_debrief
    page.should have_link "Debrief"
    start_debrief
    page.should have_text "GM points available for allocation"
  end

  def check_cannot_start_debrief
    page.should have_no_link "Debrief"
  end

  def check_asked_for_player_points
    page.should have_text "Failed to save Debrief details"
    page.should have_text "Player points base can't be blank"
  end

  def check_asked_for_player_pay
    page.should have_text "Failed to save Debrief details"
    page.should have_text "Player money base can't be blank"
  end

  def check_asked_for_monster_points
    page.should have_text "Failed to save Debrief details"
    page.should have_text "Monster points base can't be blank"
  end
end
