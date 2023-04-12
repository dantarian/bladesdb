Feature: Deleting monster point spends
  As a player with a character
  I want to be able to delete my last monster point spend on that character
  So that I can fix mistakes I have made when spending monster points

  Note: Test which actually delete the spend should be tagged with @javascript; those that merely try should not.
  
  Background:
    Given there is a user
    And the user has no joining bonus monster point adjustment
    And the user is logged in
    And the user has a character
  
  @javascript
  Scenario: Delete last monster point spend if character has never been played
  	Given there is a monster point spend on the character
  	When the user deletes the monster point spend
  	Then the monster point spend should be deleted

  @javascript
  Scenario: Delete last monster point spend if character has not played a game since
    Given there is a game one week ago
    And the character was on the game
    And the game has been debriefed
    And there is a monster point spend on the character since the game
    When the user deletes the monster point spend
    Then the monster point spend should be deleted

  @javascript
  Scenario: Delete last monster point spend if character has played since but debrief is open
    Given there is a game
    And the character was on the game
    And the game has not been debriefed
    And there is a monster point spend on the character before the game
    When the user deletes the monster point spend
    Then the monster point spend should be deleted
  
  Scenario: Cannot delete last monster point spend if character has been played on a debriefed game since
    Given there is a game
    And the character was on the game
    And there is a monster point spend on the character before the game
    And the game has been debriefed
    When the user tries to delete the monster point spend
    Then the user should be told they cannot delete a monster point spend before a debriefed game
  
  @javascript
  Scenario: Delete last monster point spend if character has been played on a debriefed game since, but it is non-stats
    Given there is a game
    And the game is a non-stats game
    And there is a monster point spend on the character before the game
    And the game has been debriefed
    When the user deletes the monster point spend
    Then the monster point spend should be deleted

  Scenario: Cannot delete last monster point spend if there is a monster point declaration since
    Given there is a monster point spend on the character one week ago
    And the user has a monster point declaration since the monster point spend
    When the user tries to delete the monster point spend
    Then the user should be told they cannot delete a monster point spend before a monster point declaration
  
  @javascript
  Scenario: Can delete last monster point spend if there is a rejected monster point declaration since
    Given there is a monster point spend on the character one week ago
    And the user has a rejected monster point declaration since the monster point spend
    When the user deletes the monster point spend
    Then the monster point spend should be deleted
  
  Scenario: Cannot delete last monster point spend if there is a monster point adjustment since
    Given there is a monster point spend on the character one week ago
    And the user has a monster point adjustment since the monster point spend
    When the user tries to delete the monster point spend
    Then user should be told they cannot delete a monster point spend before a monster point adjustment
  
  @javascript
  Scenario: Can delete last monster point spend if there is a rejected monster point adjustment since
    Given there is a monster point spend on the character one week ago
    And the user has a rejected monster point adjustment since the monster point spend
    When the user deletes the monster point spend
    Then the monster point spend should be deleted
  
  Scenario: Cannot delete last monster point spend if there is a character point adjustment since
    Given there is a monster point spend on the character one week ago
    And the character has a character point adjustment since the monster point spend
    When the user tries to delete the monster point spend
    Then user should be told they cannot delete a monster point spend before a character point adjustment
  
  @javascript
  Scenario: Can delete last monster point spend if there is a rejected character point adjustment since
    Given there is a monster point spend on the character one week ago
    And the user has a rejected character point adjustment since the monster point spend
    When the user deletes the monster point spend
    Then the monster point spend should be deleted
  
  Scenario: Cannot delete last monster point spend on a dead character
    Given there is a monster point spend on the character
    And the character is dead
    When the user tries to delete the monster point spend
    Then the user should be told they cannot delete a monster point spend on a dead character
  
  Scenario: Cannot delete last monster point spend on a retired character
    Given there is a monster point spend on the character
    And the character is retired
    When the user tries to delete the monster point spend
    Then the user should be told they cannot delete a monster point spend on a retired character
  
  Scenario: Cannot delete last monster point spend on a recycled character
    Given there is a monster point spend on the character
    And the character is recycled
    When the user tries to delete the monster point spend
    Then the user should be told they cannot delete a monster point spend on a recycled character
