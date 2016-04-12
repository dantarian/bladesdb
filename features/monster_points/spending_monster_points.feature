Feature: Spending monster points
  As a user with a character
  I want to be able to spend monster points on the character
  So that I can increase the rank of the character without playing them on a game
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character

  Scenario: Can always spend up to rank 10 at 1MP=1CP
    Given the user has 100 monster points available
    And the character has 20 character points
    When the user buys 80 character points for the character
    Then the user should have 20 monster points
    And the character should have 100 character points

  Scenario: From rank 10 to rank 20, 2MP=1CP
    Given the user has 2 monster points available
    And the character has 100 character points
    When the user buys 1 character points for the character
    Then the user should have 0 monster points
    And the character should have 101 character points

  Scenario: From rank 20 to rank 30, 3MP=1CP
    Given the user has 3 monster points available
    And the character has 200 character points
    When the user buys 1 character points for the character
    Then the user should have 0 monster points
    And the character should have 201 character points
  
  Scenario: Can spend across cost boundaries
    Given the user has 3 monster points available
    And the character has 99 character points
    When the user buys 2 character points for the character
    Then the user should have 0 monster points
    And the character should have 101 character points
    
  Scenario: Can buy up to 30CP if final rank is over rank 10
    Given the user has 31 monster points available
    And the character has 71 character points
    When the user buys 30 character points for the character
    Then the user should have 0 monster points
    And the character should have 101 character points

  Scenario: Cannot spend more monster points than you have
    Given the user has 1 monster points available
    And the character has 20 character points
    When the user tries to buy 2 monster points for the character
    Then the user should be told they cannot spend more monster points than they have available

  Scenario: Cannot buy more than 30 character points if doing so would put you over rank 10
    Given the user has 100 monster points available
    And the character has 70 character points
    When the user tries to buy 31 character points for the character
    Then the user should be told they cannot buy that many character points

  Scenario: Cannot buy 0 character points
    Given the user has 20 monster points available
    And the character has 20 character points
    When the user tries to buy 0 character points for the character
    Then the user should be told they cannot buy zero character points
    
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
    And the character has 20 character points before the game
    When the user tries to buy character points for the character before the first game
    Then the user should be told they cannot create a monster point spend before their penulitmate game
    
  Scenario: Cannot spend monster points before monster point declaration date
  
  Scenario: Cannot spend monster points before character declaration date
  