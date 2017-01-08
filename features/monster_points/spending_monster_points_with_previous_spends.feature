@javascript
Feature: Spending monster points with previous spends
  As a user with a character
  I want to be able to spend monster points on the character
  So that I can increase the rank of the character without playing them on a game
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character

  Scenario: Can create multiple spends on same character without games between
    Given the user has 100 monster points available
    And the character has 20 character points
    And the user bought 1 character point for the character yesterday
    When the user buys 1 character point for the character
    Then the character should have 22 character points
  
  Scenario: Can buy as many CP as you like for one character in mulitple spends if final rank is <= 10
    Given the user has 100 monster points available
    And the character has 20 character points
    And the user bought 1 character point for the character yesterday
    When the user buys 79 character points for the character
    Then the character should have 100 character points
  
  Scenario: Can buy up to 30 CP in total for one character in multiple spends if final rank is > 10
    Given the user has 100 monster points available
    And the character has 71 character points
    And the user bought 1 character point for the character yesterday
    When the user buys 29 character points for the character
    Then the character should have 101 character points
  
  Scenario: Cannot buy more than 30 CP in total for one character in multiple spends if final rank is > 10
    Given the user has 100 monster points available
    And the character has 70 character points
    And the user bought 1 character point for the character yesterday
    When the user tries to buy 30 character points for the character
    Then the user should be told they cannot buy more than 29 character points