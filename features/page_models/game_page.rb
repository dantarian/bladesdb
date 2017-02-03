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
    click_link "Start Debrief"
    fill_in("Player Base", with: player_base)
    fill_in("Monster Base", with: monster_base)
    fill_in("Danger Pay", with: danger_pay)
    click_button "Save"
  end

  # Validation methods

  def check_for_application(from: nil, id: 1, containing_text: "This is a game.")
    page.click_link("View applications")
    search = "tr#application" + id.to_s
    page.find(search).should have_text(from.name)
    page.find(search).should have_text(containing_text)
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

end
