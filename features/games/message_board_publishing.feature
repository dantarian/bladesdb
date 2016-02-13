Feature: Posting boards messages from games
  As a GM
  I want to publish a board message when I have updated a game brief or debrief
  So that other users know that the update has been made

  Background:
    Given there is a user
    And the user is logged in
    And there is a game
    And the user is the GM for the game

  Scenario: GM can publish the briefs for a game
    Given the game is in the future
    And there is a Briefs board
    When the user publishes the brief for the game
    Then a Brief Published message appears on the Briefs board
    And the message includes a link to the game

  Scenario: GM publishes debrief for a game when the game is finalised
    Given the game is in the past
    And the game has been debriefed
    And there is a Debriefs board
    When the user publishes the debrief for the game
    Then a Debrief Published message appears on the Debriefs board
    And the message includes a link to the game

