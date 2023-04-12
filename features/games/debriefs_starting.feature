@javascript
Feature: Debriefs - Starting
  As a GM
  I want to debrief games
  So that players and monsters can get points and feedback

  Background:
    Given there is a user
    And the user has no joining bonus monster point adjustment
    And there is a game in the past
    And the user is a GM for the game
    And the user is logged in

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
    When the user attempts to start the debrief without supplying base points for the players
    Then the user should be told they must supply base player points

  Scenario: Must supply base pay for players
    When the user attempts to start the debrief without supplying base pay for the players
    Then the user should be told they must supply base player pay

  Scenario: Must supply base points for monsters
    When the user attempts to start the debrief without supplying base points for the monsters
    Then the user should be told they must supply base monster points

  Scenario: Players who have signed up to the game are automatically added to the debrief
    Given there is another user
    And the other user has a character
    And the other user has signed up to the game as the character
    When the user starts the debrief
    Then the character should be included in the debrief

  Scenario: Players who have been rejected are not automatically added to the debrief
    Given there is another user
    And the other user has a character
    And the other user has signed up to the game as the character
    And the character has been rejected
    When the user starts the debrief
    Then the character should not be included in the debrief

  Scenario: GMs are automatically added to the debrief
    When the user starts the debrief
    Then the user should be included in the debrief as a GM

  Scenario: Monsters who have signed up to the game are automatically added to the debrief
    Given there is another user
    And the other user has signed up to the game as a monster
    When the user starts the debrief
    Then the other user should be included in the debrief as a monster
