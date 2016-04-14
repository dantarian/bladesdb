Feature: Member List
  As an member
  I want to be able to see the member list
  So I can interact with other members

  Scenario: All users page - Non-Admin
  	Given there is a user
  	And the user is logged in
  	And there is another user
  	And the other user is a web-only user
  	When the user goes to the members page
    Then the user should be in the Active Members table
    And the other user should be in the Web-only Members table
    And there should be no other tables
    And there should be no user management links
    And there should be merge users link
    
  Scenario: Accessing profiles
  	Given there is a user
  	And the user is logged in
  	When the user goes to the members page
    And the user clicks on their name
    Then the user's profile should be displayed