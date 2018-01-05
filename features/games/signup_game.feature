@javascript
Feature: Game Signups
  As a club member
  I want to be able to sign up for games and other events
  So that the people running the game/event know whether or not to expect me

  Background:
    Given there is a game in the future
    And there is a user
    And the user has a character
    And the user is logged in

  Scenario: Cannot sign up as a player to a game that's not open
    Given the game is not open
    Then the user should not be able to sign up to play the game

  Scenario: Cannot sign up as a monster to a game that's not open
    Given the game is not open
    Then the user should not be able to sign up to monster the game

  Scenario: Cannot mark self as not attending a game that's not open
    Given the game is not open
    Then the user should not be able to mark themselves as not attending the game

  Scenario: Can sign up as a player to a game that's open
    Given the game is open
    When the user signs up to play the game as the character
    Then the user should appear as requesting to play the game as the character

  Scenario: Can sign up as a monster to a game that's open
    Given the game is open
    When the user signs up to monster the game
    Then the user should appear as requesting to monster the game

  Scenario: Can mark self as not attending a game that's open
    Given the game is open
    When the user marks themselves as not attending the game
    Then the user should appear as not attending the game

  Scenario: Cannot sign up as attending to a game that's open
    Given the game is open
    Then the user should not be able to mark themselves as attending the game
