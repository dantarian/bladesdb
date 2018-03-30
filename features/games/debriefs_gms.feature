@javascript
Feature: Debriefs - GMs
  As a GM
  I want to debrief games
  So that players and monsters can get points and feedback

  Background:
    Given there is a user
    And there is a Debriefs board
    And there is a game in the past
    And the user is a GM for the game
    And the user is logged in
    And the debrief has been started for the game

  Scenario: GMs can be added to the debrief
    Given there is another user
    When the user adds the other user to the debrief as a GM
    Then the other user should be included in the debrief as a GM

  Scenario: GMs can be removed from the debrief
    Given there is another user
    And the other user is included in the debrief as a GM
    When the user removes the other user from the debrief as a GM
    Then the other user should not be included in the debrief as a GM

  Scenario: GMs default to earning Monster Base
    When the user views the game
    Then the GM should start with 5 points

  Scenario: GMs are able to share the difference between Monster Base and Player Base between them
    When the user views the game
    Then there should be 5 GM points to share between GMs

  Scenario: GMs cannot have base points higher than Monster Base
    When the user attempts to set their base points higher than monster base
    Then the user should be told that GM base points cannot be higher than monster base

  Scenario: Single GM cannot be allocated more GM points than are available
    When the user attempts to allocate themselves more GM points than are available
    Then the user should be told they cannot allocate more GM points than are available

  Scenario: Across multiple GMs, cannot allocate more GM points than are available
    Given there is another user
    And the other user is included in the debrief as a GM
    When the user attempts to allocate more GM points than are available across all gms
    Then the user should be told they cannot allocate more GM points than are available

  Scenario: GMs cannot also be monsters
    When the user attempts to add themselves to the debrief as a monster
    Then the user should not be in the list of users

  Scenario: GMs can also be players
    Given the user has a character
    When the user adds themselves to the debrief as having played the character
    And the user closes the debrief
    Then the user should be included in the debrief as a GM
    And the character should be included in the debrief
