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
