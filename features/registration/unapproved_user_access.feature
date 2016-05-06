Feature: Unapproved User Access
	As an unapproved user
	I want to be able to access the parts of the website I'm allowed to access
	So I can use the website.
	
	Background:
		Given there is an unapproved user
    And the user is logged in

  Scenario: View members page as unapproved user
    When the user goes to the members page
    Then the home page should be displayed
    And the user should see an unauthorised access message
    
  Scenario: View message board as unapproved user
    Given there is another user
    And there is a message board
    And there is message from another user
    When the user goes to the message board
    Then the user should see a short name and no email on the message
  
  Scenario: View characters page as unapproved user
    Given there is another user
    And the other user has a character
    When the user goes to the characters page
    Then the user should see a short user name and character link on the character
  
  @javascript
  Scenario: View event calendar as unapproved user
    Given there is a game
    And there is a GM for the game
    And there is a player for the game
    And there is a monster for the game
    And there is a non-attendee for the game
    When the user goes to the event calendar
    Then the user should see a short user name for the gm
    And the user should see a short user name for the player
    And the user should see a short user name for the monster
    And the user should see a short user name for the non-attendee