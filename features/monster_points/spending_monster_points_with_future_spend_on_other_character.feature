Feature: Spending monster points with a future spend on another character
  As a user with a character and a future monster point spend on another character
  I want to be able to spend monster points on the character
  So that I can increase the rank of the character without playing them on a game
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character
    And the user has another character
    And the other character has a monster point spend costing 10 monster points
    
  Scenario Outline: Spending monster points successfully
    Given the user has <start_mp> monster points available before the future spend
    And the character has <start_cp> character points
    When the user buys <to_buy> character points for the character before the future spend
    Then the user should have <final_mp> monster points
    And the character should have <final_cp> character points
    
    Examples:
      | start_mp | start_cp | to_buy | final_mp | final_cp |
      | 90       | 20       | 80     | 0        | 100      |
      | 30       | 90       | 11     | 8        | 101      |
      | 100      | 90       | 30     | 40       | 120      |
      | 100      | 100      | 30     | 30       | 130      |
      | 100      | 190      | 20     | 40       | 210      |
      
  Scenario Outline: Failing to spend monster points
    Given the user has <start_mp> monster points available before the future spend
    And the character has <start_cp> character points
    When the user tries to buy <to_buy> character points for the character before the future spend
    Then the user should be told they cannot spend more monster points than they have available
    
    Examples:
      | start_mp | start_cp | to_buy |
      | 100      | 20       | 71     |
      | 70       | 20       | 61     |
      | 11       | 100      | 1      |
    