Feature: Logged Out User Access
	As a logged out user
	I want to be banned from the non-public parts of the website
	So I cannot see things I shouldn't.

  Background:
    Given there is a user
    And the user is not logged in

  Scenario: Attempt to access restricted page without being signed in
    Given there is a restricted page
    When the user goes to the page
    Then the home page should be displayed
    And the user should see a login access message

  Scenario: Attempt to access message boards without being signed in
    Given there is an OOC message board
    When the user goes to the message board
    Then the login page should be displayed
    And the user should see a login access message

  Scenario: Attempt to access users list without being signed in
    When the user goes to the members page
    Then the login page should be displayed
    And the user should see a login access message

  Scenario: Attempt to access characters list without being signed in in
    When the user goes to the characters page
    Then the login page should be displayed
    And the user should see a login access message

  @javascript
  Scenario: View event calendar without being signed in
    Given there is a game
    And there is a GM for the game
    And there is a player for the game
    And there is a monster for the game
    And there is a non-attendee for the game
    When the user goes to the event calendar
    Then the user should see no name for the gm
    And the user should only see the game summary
