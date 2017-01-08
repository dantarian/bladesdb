@javascript
Feature: Spends changing in cost after character point adjustment resolution
  As a user with a character
  I want to be informed if a change in an approved character point adjustment affects my monster point spends
  So that I can make sure my rank is what I expect it to be
  
  Background:
    Given there is a user
    And the user has 10 monster points available
    And the user has a character
    And there is a character ref user

  Scenario: Having spent monster points after a pending character point adjustment, the adjustment is approved such that your spend is cheaper
    Given the character has 200 character points
    And the character has a pending character point adjustment for -1 character points
    And the user bought 1 character point for 3 monster points for the character after the character point adjustment
    When the character ref logs in
    And the character ref approves the character point adjustment
    And the character ref logs out
    And the user logs in
    Then the user should have 8 monster points
    And the character should have 200 character points
    And the user should receive an e-mail telling them that their monster point spend has reduced in cost
  
  Scenario: Having spent monster points after a pending character point adjustment, the adjustment is rejected such that your spend is cheaper
    Given the character has 199 character points
    And the character has a pending character point adjustment for 1 character point
    And the user bought 1 character point for 3 monster points for the character after the character point adjustment
    When the character ref logs in
    And the character ref rejects the character point adjustment
    And the character ref logs out
    And the user logs in
    Then the user should have 8 monster points
    And the character should have 200 character points
    And the user should receive an e-mail telling them that their monster point spend has reduced in cost
  
  Scenario: Having spent monster points after a pending character point adjustment, the adjustment is approved such that your spend is the same cost
    Given the character has 201 character points
    And the character has a pending character point adjustment for -1 character points
    And the user bought 1 character point for 3 monster points for the character after the character point adjustment
    When the character ref logs in
    And the character ref approves the character point adjustment
    And the character ref logs out
    And the user logs in
    Then the user should have 7 monster points
    And the character should have 201 character points
  
  Scenario: Having spent monster points after a pending character point adjustment, the adjustment is rejected such that your spend is the same cost
    Given the character has 200 character points
    And the character has a pending character point adjustment for 1 character point
    And the user bought 1 character point for 3 monster points for the character after the character point adjustment
    When the character ref logs in
    And the character ref rejects the character point adjustment
    And the character ref logs out
    And the user logs in
    Then the user should have 7 monster points
    And the character should have 201 character points
  