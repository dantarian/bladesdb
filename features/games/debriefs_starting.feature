Feature: Debriefs - Starting
  As a GM
  I want to debrief games
  So that players and monsters can get points and feedback

  Background:
    Given there is a user
    And there is a game in the past
    And the user is a GM for the game

  Scenario: GM can start debrief after start time of game
    When the user views the game
    Then the user should be able to start the debrief for the game

  Scenario: Committee can start debrief after the start time of the game
    Given the user is not a GM for the game
    And the user is a committee member
    When the user views the game
    Then the user should be able to start the debrief for the game

  Scenario: Cannot start debrief before start time of game
    Given the game is starting later today
    When the user views the game
    Then the user should not be able to start the debrief for the game

  Scenario: Must supply base points for players
    Given the user has not supplied base points for the players
    When the user attempts to start the debrief
    Then the user should be told they must supply base player points

  Scenario: Must supply base pay for players
    Given the user has not supplied base pay for the players
    When the user attempts to start the debrief
    Then the user should be told they must supply base player pay

  Scenario: Must supply base points for monsters
    Given the user has not supplied base monster points
    When the user attempts to start the debrief
    Then the user should be told they must supply base monster points
