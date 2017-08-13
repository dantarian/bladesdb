@javascript
Feature: Reopening and closing old debriefs
  As a GM
  I want to be able to correct old debriefs
  So my players and monsters have the points they should have

  Background:
    Given there is a Debriefs board

  Scenario: Reopened debrief is before January 7th 2017 and the character has a MP spend before January 7th 2017
    Given there is a user
    And the user has a character declared one month before the monster spend cut-off
    And the character has 100 monster points available two weeks before the monster spend cut-off
    And there is a game before the monster spend cut-off
    And there is a GM for the game
    And the user's character is present on the game
    And the game has been debriefed
    And the character has a monster point spend before the cut-off that takes the character to rank 10.0
    And the GM is logged in
    When the GM reopens the debrief for the game
    And the GM gives the character a bonus point
    And the GM closes the debrief for the game
    Then the debrief should close successfully
    And the user should have 30 monster points
    And the character should have 101 character points

  Scenario: Reopened debrief is before January 7th 2017 and the character has a MP spend after January 7th 2017
    Given there is a user
    And the user has a character declared one month before the monster spend cut-off
    And the character has 100 monster points available two weeks before the monster spend cut-off
    And there is a game after the monster spend cut-off
    And there is a GM for the game
    And the user's character is present on the game
    And the game has been debriefed
    And the character has a monster point spend after the cut-off that takes the character to rank 10.0
    And the GM is logged in
    When the GM reopens the debrief for the game
    And the GM gives the character a bonus point
    And the GM closes the debrief for the game
    Then the debrief should close successfully
    And the user should have 29 monster points
    And the character should have 101 character points

  Scenario: Reopened debrief has a following closed debrief
    Given there is a user
    And the user has a character declared one month before the monster spend cut-off
    And the character has 100 monster points available two weeks before the monster spend cut-off
    And there is a game after the monster spend cut-off
    And there is a GM for the game
    And the user's character is present on the game
    And the game has been debriefed
    And the character has a monster point spend after the cut-off that takes the character to rank 10.0
    And there is a game one week ago
    And the user's character is present on the other game
    And the other game has been debriefed
    And the GM is logged in
    When the GM reopens the debrief for the game
    And the GM gives the character a bonus point
    And the GM closes the debrief for the game
    Then the debrief should close successfully
    And the user should have 29 monster points
    And the character should have 101 character points
