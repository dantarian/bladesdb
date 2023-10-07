@javascript
Feature: Preventing monster point spends
  As the system
  I want to be able to prevent erroneous monster point spends
  So that I can maintain the integrity of the system
  
  Background:
    Given there is a user
    And the user has no joining bonus monster point adjustment
    And the user is logged in
    And the user has a character

  Scenario: Cannot spend monster points in the future
  	Given the user has monster points available
  	When the user tries to spend monster points on the character on a date in the future
  	Then the user should be told they cannot create a monster point spend in the future
  	
  Scenario: Cannot spend monster points before an existing monster point spend on the character
    Given the user has monster points available
    And there is a monster point spend on the character
    When the user tries to spend monster points before the monster point spend
    Then the user should be told they cannot create a monster point spend before their last monster point spend

  Scenario: Can spend monster points before an existing monster point spend on another character
    Given the user has 20 monster points available
    And the character has 20 character points
    And the user has another character
    And the user bought 1 character point for 1 monster point for the other character
    When the user buys 1 character point for the character before the monster point spend on the other character
    Then the character should have 21 character points
    And the user should have 18 monster points
    
  Scenario: Cannot spend monster points before an existing monster point spend on another character if doing so would put you in debt
    Given the user has 20 monster points available
    And the user has monstered a debriefed game and earned 5 monster points
    And the user has another character
    And the user bought 15 character points for 15 monster points for the other character before the game
    When the user tries to buy 6 character points for the character before the monster point spend on the other character
    Then the user should be told they cannot buy more than 5 character points
    
  Scenario: Cannot spend monster points before they have been earned
    Given the user has 20 monster points available
    And the user has monstered a debriefed game and earned 5 monster points
    And the character has 20 character points
    When the user tries to buy 25 character points for the character before the game
    Then the user should be told they cannot buy more than 20 character points
  	  
  Scenario: Cannot spend monster points before a monster point declaration
    Given the user has a monster point declaration one week ago
    When the user tries to spend monster points on the character before their monster point declaration
    Then the user should be told they cannot create a monster point spend before their monster point declaration

  Scenario: Can spend monster points before a rejected monster point declaration
    Given the user has earned 20 monster points
    And the character has 20 character points
    And the user has a rejected monster point declaration one week ago
    When the user buys 1 character point for the character before their monster point declaration
    Then the character should have 21 character points
  
  Scenario: Cannot spend monster points with a pending monster point declaration if points spent is greater than points available without the declaration
    Given the user has earned 10 monster points
    And the user has a pending monster point declaration for 11 monster points
    When the user tries to buy 11 character points for the character
    Then the user should be told they cannot buy more than 10 character points
  
  Scenario: Cannot spend monster points with a pending monster point declaration if points spent is greater than points available with the declaration
    Given the user has earned 11 monster points
    And the user has a pending monster point declaration for 10 monster points
    When the user tries to buy 11 character points for the character
    Then the user should be told they cannot buy more than 10 character points
  
  Scenario: Can spend monster points with a pending monster point declaration if points spent less than or equal to points available both with and without the declaration
    Given the character has 20 character points 
    And the user has earned 10 monster points
    And the user has a pending monster point declaration for 11 monster points
    When the user buys 10 character points for the character
    Then the character should have 30 character points
  
  Scenario: Cannot spend monster points with a pending monster point adjustment if points spent is greater than points available without the adjustment
    Given the user has 10 monster points available
    And the user has a pending monster point adjustment for +10 monster points
    When the user tries to buy 11 character points for the character
    Then the user should be told they cannot buy more than 10 character points
  
  Scenario: Cannot spend monster points with a pending monster point adjustment if points spent is greater than points available with the adjustment
    Given the user has 10 monster points available
    And the user has a pending monster point adjustment for -5 monster points
    When the user tries to buy 6 character points for the character
    Then the user should be told they cannot buy more than 5 character points
  
  Scenario: Can spend monster points with a pending monster point adjustment if points spent is less than or equal to points available both with and without the adjustment
    Given the character has 20 character points 
    And the user has 11 monster points available
    And the user has a pending monster point adjustment for -1 monster points
    When the user buys 10 character points for the character
    Then the character should have 30 character points

  Scenario: Cannot spend monster points before a character point adjustment on the character
    Given the user has monster points available
    And there is a character point adjustment on the character
    When the user tries to spend monster points before the character point adjustment
    Then the user should be told they cannot create a monster point spend before the character point adjustment
    
  Scenario: Can spend monster points before a rejected character point adjustment
    Given the user has 20 monster points available
    And the character has 20 character points
    And there is a rejected character point adjustment on the character
    When the user buys 1 character point for the character before the character point adjustment
    Then the character should have 21 character points
    
  Scenario: Cannot spend monster points with a pending character point adjustment if cost is greater than points available without the adjustment
    Given the character has 100 character points
    And the user has 3 monster points available
    And the character has a pending character point adjustment for -1 character point
    When the user tries to buy 2 character points for the character after the character point adjustment
    Then the user should be told they cannot spend more than 3 monster points
  
  Scenario: Cannot spend monster points with a pending character point adjustment if cost is greater than points available with the adjustment
    Given the character has 98 character points
    And the user has 2 monster points available
    And the character has a pending character point adjustment for 2 character points
    When the user tries to buy 2 character points for the character after the character point adjustment
    Then the user should be told they cannot spend more than 2 monster points
  
  Scenario: Can spend monster points with a pending character point adjustment if cost is less than or equal to points available both with and without the adjustment
    Given the character has 100 character points
    And the user has 20 monster points available
    And the character has a pending character point adjustment for -1 character point
    When the user buys 2 character points for the character after the character point adjustment
    Then the character should have 102 character points
    And the user should have 16 monster points
    
  Scenario: Cannot buy more than 30 character points with a pending character point adjustment if final rank with the adjustment would be more than 10.
    Given the character has 60 character points
    And the user has 100 monster points available
    And the character has a pending character point adjustment for 5 character points
    When the user tries to buy 40 character points for the character after the character point adjustment
    Then the user should be told they cannot buy more than 35 character points
  
  Scenario: Cannot buy more than 30 character points with a pending character point adjustment if final rank without the adjustment would be more than 10.
    Given the character has 75 character points
    And the user has 100 monster points available
    And the character has a pending character point adjustment for -10 character points
    When the user tries to buy 35 character points for the character after the character point adjustment
    Then the user should be told they cannot buy more than 30 character points
  
  Scenario: Can buy more than 30 character points with a pending character point adjustment if final rank both with and without the adjustment would be less than or equal to 10.
    Given the character has 20 character points
    And the user has 100 monster points available
    And the character has a pending character point adjustment for 10 character points
    When the user tries to buy 40 character points for the character after the character point adjustment
    Then the character should have 60 character points
    And the user should have 60 monster points

  Scenario: Cannot spend monster points prior to character declaration
    Given the user has monster points available
    When the user tries to spend monster points on the character before the character was declared
    Then the user should be told they cannot create a monster point spend before the character was declared
  
  Scenario: Cannot spend monster points with a pending character declaration
    Given the character is pending approval
    And the user has 10 monster points available
    Then there should be no option for spending monster points
    And the user should be told they cannot spend monster points on an unapproved character
  
  Scenario: Cannot spend monster points on a retired character
    Given the character is retired
    And the user has 10 monster points available
    Then there should be no option for spending monster points
    And the user should be told they cannot spend monster points on a retired character
  
  Scenario: Cannot spend monster points on a dead character
    Given the character is dead
    And the user has 10 monster points available
    Then there should be no option for spending monster points
    And the user should be told they cannot spend monster points on a dead character
  
  Scenario: Cannot spend monster points on a recycled character
    Given the character is recycled
    And the user has 10 monster points available
    Then there should be no option for spending monster points
  
  Scenario: Cannot spend monster points on an undeclared character
    Given the character is undeclared
    And the user has 10 monster points available
    Then there should be no option for spending monster points
