Feature: Editing monster point spends
  As a user with a character and a monster point spend
  I want to be able to edit an existing monster point spend on the character
  So that I can correct mistakes if I spend too many or too few points
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character
    And the character has bought 2 character points with monster points
    
  Scenario Outline: Editing monster point spends successfully
    Given the user has <start_mp> monster points available before the spend
    And the character has <start_cp> character points before the spend
    When the user edits the spend to buy <to_buy> character points for the character
    Then the user should have <final_mp> monster points
    And the character should have <final_cp> character points
    
    Examples:
      | start_mp | start_cp | to_buy | final_mp | final_cp |
      | 100      | 20       | 80     | 20       | 100      |
      | 100      | 20       | 1      | 99       | 21       |
      | 30       | 90       | 11     | 18       | 101      |
      | 100      | 90       | 30     | 50       | 120      |
      | 100      | 100      | 30     | 40       | 130      |
      | 100      | 190      | 20     | 50       | 210      |
      
  Scenario Outline: Failing to spend monster points - not enough monster points
    Given the user has <start_mp> monster points available before the spend
    And the character has <start_cp> character points before the spend
    When the user edits the spend to try to buy <to_buy> character points for the character
    Then the user should be told they cannot spend more monster points than they have available
    
    Examples:
      | start_mp | start_cp | to_buy |
      | 100      | 20       | 81     |
      | 70       | 20       | 71     |
      | 11       | 90       | 11     |
      | 100      | 90       | 31     |
      | 100      | 90       | 0      |

  Scenario Outline: Failing to spend monster points - too many character points
    Given the user has <start_mp> monster points available before the spend
    And the character has <start_cp> character points before the spend
    When the user edits the spend to try to buy <to_buy> character points for the character
    Then the user should be told they cannot buy that many character points

    Examples:
      | start_mp | start_cp | to_buy |
      | 100      | 20       | 81     |
      | 100      | 90       | 31     |

  Scenario: Failing to spend monster points - zero monster points
    Given the user has 20 monster points available before the spend
    And the character has 20 character points before the spend
    When the user edits the spend to try to buy 0 character points for the character
    Then the user should be told they cannot buy that many character points
          