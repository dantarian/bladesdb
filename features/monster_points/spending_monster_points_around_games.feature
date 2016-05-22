@javascript
Feature: Spending monster points around games
  As a user with a character
  I want to be able to spend monster points on the character
  So that I can increase the rank of the character without playing them on a game
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character

  Scenario: Can spend after a game played as the character
  
  Scenario: Cannot spend before a game played as the character if it has been debriefed
  
  Scenario: Can spend before a game played as the character if the debrief has not been started
  
  Scenario: Can spend before a game played as the character if the debrief has not been finished
  
  Scenario: Cannot retrospectively buy CP that would put you over the rank bracket for the game
  
  Scenario: After playing a game, the number of CP you can buy is reset
  
  Scenario: After playing a non-stats game, the number of CP you can buy is not reset
  
