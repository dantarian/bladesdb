Feature: Member List
  As an member
  I want to be able to see the member list
  So I can interact with other members
  
  Background: 
  	Given there is a user
  	And the user is logged in

  Scenario: All users page - Non-Admin
  	Given there is a web-only user
  	And there is a suspended user
  	And there is a deleted user
  	And there is an unconfirmed user
  	And there is an unapproved user
  	When the user goes to the members page
    Then the user should be in the Active Members table
    And the other user should be in the Web-only Members table
    And the user should not see any other tables
    And the user should not see any user management links
    And the user should not see a merge users link
    
  Scenario: Accessing own profile
  	When the user goes to the members page
    And the user clicks on their name
    Then the user's profile should be displayed
    
  Scenario: Accessing other profile
  	Given there is another user
  	When the user goes to the members page
    And the user clicks on the other user's name
    Then the other user's profile should be displayed