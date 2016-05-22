@javascript
Feature: Preventing monster point spends
  As the system
  I want to be able to prevent erroneous monster point spends
  So that I can maintain the integrity of the system
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character

  Scenario: Cannot spend monster points in the future
  
  Scenario: Cannot spend monster points before a monster point declaration
  
  Scenario: Cannot spend monster points with a pending monster point declaration if points spent is greater than points available without the declaration
  
  Scenario: Cannot spend monster points with a pending monster point declaration if points spent is greater than points available with the declaration
  
  Scenario: Can spend monster points with a pending monster point declaration if points spent less than points available both with and without the declaration
  
  Scenario: Cannot spend monster points with a pending monster point adjustment if points spent is greater than points available without the adjustment
  
  Scenario: Cannot spend monster points with a pending monster point adjustment if points spent is greater than points available with the adjustment
  
  Scenario: Can spend monster points with a pending monster point adjustment if points spent is less than points available both with and without the adjustment

  Scenario: Cannot spend monster points prior to character declaration
  
  Scenario: Cannot spend monster points with a pending character declaration
  
  Scenario: Cannot spend monster points on a retired character
  
  Scenario: Cannot spend monster points on a dead character
  
  Scenario: Cannot spend monster points on a recycled character
  
  Scenario: Cannot spend monster points on an undeclared character

  Scenario: Can spend monster points retroactively before the last game played
    Given the user has 20 monster points available
    And the character has been played on a debriefed game and earned 10 character points
    And the character has 20 character points before the game
    When the user buys 10 character points for the character before the game
    Then the user should have 10 monster points
    And the character should have 40 character points
  
  Scenario: Cannot spend monster points retroactively before the last-but-one game played
    Given the user has 20 monster points available
    And the character has been played on a debriefed game and earned 10 character points
    And the character has been played on another debriefed game and earned 10 character points
    And the character has 20 character points before the games
    When the user tries to buy character points for the character before the first game
    Then the user should be told they cannot create a monster point spend before their penultimate game
    
  Scenario: Cannot spend monster points before they have been earned
    Given the user has 20 monster points available
    And the user has monstered a debriefed game and earned 5 monster points
    And the character has 20 character points
    When the user tries to buy 25 character points for the character before the game
    Then the user should be told they cannot spend more than 20 monster points
    
  Scenario: Cannot spend monster points before monster point declaration date
    Given the user has a monster point declaration one week ago
    When the user tries to spend monster points on the character before their monster point declaration
    Then the user should be told they cannot create a monster point spend before their monster point declaration
  
  Scenario: Cannot spend monster points before character declaration date
    Given the user has monster points available
    When the user tries to spend monster points on the character before the character was declared
    Then the user should be told they cannot create a monster point spend before the character was declared
  
  Scenario: Cannot spend monster points in the future
  	Given the user has monster points available
  	When the user tries to spend monster points on the character on a date in the future
  	Then the user should be told they cannot create a monster point spend in the future