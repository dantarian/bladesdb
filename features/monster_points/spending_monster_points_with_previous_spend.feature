Feature: Spending monster points with previous spend
  As a user with a character with a monster point spend since the last game
  I want to be able to spend monster points on the character
  So that I can increase the rank of the character without playing them on a game
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character
    And the character has been played on a debriefed game and earned 10 character points
    
  Scenario Outline: Spending monster points successfully
    Given the user has <start_mp> monster points available before the game
    And the character had <start_cp> character points before the game
    And the character has bought 2 character points with monster points since the game
    When the user buys <to_buy> character points for the character
    Then the user should have <final_mp> monster points
    And the character should have <final_cp> character points
    
    Examples:
      | start_mp | start_cp | to_buy | final_mp | final_cp |
      | 100      | 20       | 68     | 30       | 100      |
      | 30       | 80       | 11     | 14       | 103      |
      | 100      | 78       | 28     | 52       | 118      |
      | 100      | 88       | 28     | 42       | 128      |
      | 100      | 178      | 20     | 46       | 210      |
      
  Scenario Outline: Failing to spend monster points
    Given the user has <start_mp> monster points available before the game
    And the character had <start_cp> character points before the game
    And the character has bought 2 character points with monster points since the game
    When the user tries to buy <to_buy> character points for the character
    Then the user should be told they cannot buy that many character points
    
    Examples:
      | start_mp | start_cp | to_buy |
      | 100      | 20       | 69     |
      | 100      | 90       | 29     |

  Scenario: Cannot create a monster point spend earlier than the last one on the character
    Given the user has 20 monster points available
    And the character has 20 character points
    And the character has bought 2 character points with monster points
    When the user tries to buy character points before the monster point spend
    Then the user should be told they cannot create an older monster point spend
    
      