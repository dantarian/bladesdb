@javascript
Feature: Game Applications - Applying
  As a prospective GM
  I want to be able to apply to run games
  So that the committee can award me a game

  Background:
    Given there is a user
    And the user is logged in
    And there is a game

  Scenario: User can apply for a game with no applications
    Given there are no applications for the game
    When the user applies for the game
    Then the game should have an application for the user

  Scenario: User can apply for a game with some applications
    Given there is another user
    And the other user has an application for the game
    When the user applies for the game
    Then the game should have an application for the user

  Scenario: User cannot apply for a game that has been awarded
    Given there is another user
    And the other user has been awarded the game
    Then the user should not be able to apply for the game

  Scenario: User cannot apply a second time for a game they have already applied for
    Given the user has applied for the game
    Then the user should not be able to apply for the game

  Scenario: User can edit their application for a game
    Given the user has applied for the game
    When the user edits their application for the game
    Then the game should have a modified application for the user

  Scenario: User can withdraw their application for a game
    Given the user has applied for the game
    When the user withdraws their application for the game
    Then the game should not have an application for the user
