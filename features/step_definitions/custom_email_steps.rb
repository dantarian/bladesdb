# Set-up steps


# Action steps
When("the user sends a message to current members") do
    CommitteeEmailPage.new.visit_page(new_committee_contact_path)
                          .and.send_message(type: "Current members")
end

When("the user sends a message to web-only users") do
    CommitteeEmailPage.new.visit_page(new_committee_contact_path)
                          .and.send_message(type: "Web-only members")
end

When("the user sends a message to experienced GMs") do
    CommitteeEmailPage.new.visit_page(new_committee_contact_path)
                          .and.send_message(type: "Experienced GMs")
end

When("the user sends a message to first-aiders") do
    CommitteeEmailPage.new.visit_page(new_committee_contact_path)
                          .and.send_message(type: "First Aiders")
end

When("the user sends a message to insurance-responsible persons") do
    CommitteeEmailPage.new.visit_page(new_committee_contact_path)
                          .and.send_message(type: "Insurance Responsibles")
end

When("the user sends a message to monsters on the game") do
    GMEmailPage.new.visit_page(new_game_gm_contact_path(Game.first.id))
                   .and.send_message(type: "Monsters")
end

When("the user sends a message to monsters on the game including the character refs") do
    GMEmailPage.new.visit_page(new_game_gm_contact_path(Game.first.id))
                   .and.send_message_including_character_refs(type: "Monsters")
end

When("the user sends a message to monsters on the game including the committee") do
    GMEmailPage.new.visit_page(new_game_gm_contact_path(Game.first.id))
                   .and.send_message_including_committee(type: "Monsters")
end

When("the user sends a message to players on the game") do
    GMEmailPage.new.visit_page(new_game_gm_contact_path(Game.first.id))
                   .and.send_message(type: "Players")
end

When("the user sends a message to all attendees of the game") do
    GMEmailPage.new.visit_page(new_game_gm_contact_path(Game.first.id))
                   .and.send_message(type: "Everybody")
end

# Verification steps

Then("the other user should receive the message") do
    expect(unread_emails_for(User.all.second.email).size).to eql parse_email_count(1)
end
  
Then("the message should have the specified subject") do
    open_email(User.all.second.email, :with_subject => "Subject")
end
  
Then("the message should have the specified content") do
    open_email(User.all.second.email, :with_text => "Message content")
end
  
Then("the third user should not receive the message") do
    expect(unread_emails_for(User.last.email).size).to eql parse_email_count(0)
end

Then("the monster should receive the message") do
    expect(unread_emails_for("monster@mail.com").size).to eql parse_email_count(1)
end
  
Then("the message to the monster should have the specified subject") do
    open_email("monster@mail.com", :with_subject => "Subject")
end
  
Then("the message to the monster should have the specified content") do
    open_email("monster@mail.com", :with_text => "Message content")
end
  
Then("the player should not receive the message") do
    expect(unread_emails_for("player@mail.com").size).to eql parse_email_count(0)
end
  
Then("the player should receive the message") do
    expect(unread_emails_for("player@mail.com").size).to eql parse_email_count(1)
end
  
Then("the message to the player should have the specified subject") do
    open_email("player@mail.com", :with_subject => "Subject")
end
  
Then("the message to the player should have the specified content") do
    open_email("player@mail.com", :with_text => "Message content")
end
  
Then("the monster should not receive the message") do
    expect(unread_emails_for("monster@mail.com").size).to eql parse_email_count(0)
end
  
Then("the character refs should receive the message") do
    expect(unread_emails_for("characterrefs@bathlarp.co.uk").size).to eql parse_email_count(1)
end
  
Then("the committee should receive the message") do
    expect(unread_emails_for("committee@bathlarp.co.uk").size).to eql parse_email_count(1)
end
