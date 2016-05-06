Feature: Deleting monster point spends
  As a player with a character
  I want to be able to delete my last monster point spend on that character
  So that I can fix mistakes I have made when spending monster points
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character
  
  Scenario: Delete last monster point spend if character has never been played
  	Given there is a monster point spend on the character
  	When the user deletes the monster point spend
  	Then the monster point spend should be deleted

  Scenario: Delete last monster point spend if character has not played a game since

  Scenario: Delete last monster point spend if character has played since but debrief is open
  
  Scenario: Cannot delete last monster point spend if character has been played on a debriefed game since
  
  Scenario: Delete last monster point spend if character has been played on a debriefed game since, but it is non-stats

  Scenario: Cannot delete last monster point spend if there is a monster point declaration since
  
  Scenario: Cannot delete last monster point adjustment if there is a monster point adjustment since
  
  Scenario: Cannot delete last monster point spend on a dead character
  
  Scenario: Cannot delete last monster point spend on a retired character
  
  Scenario: Cannot delete last monster point spend on a recycled character
  
  Scenario: Delete last monster point spend if made since character last played
    Given the character has played on a debriefed game
    And there is a monster point spend on the character since the last game
    When the user deletes the monster point spend
    Then the monster point spend should be deleted
  
  Scenario: Delete last monster point spend if made since last-but-one game character played
  	Given the character has played on a debriefed game
  	And there is a monster point spend on the character before the last game
  	When the user deletes the monster point spend
  	Then the monster point spend should be deleted
  
  Scenario: Cannot delete last monster point spend if made before last-but-one game character played (no link)
    Given the character has played on two debriefed games
    And there is a monster point spend on the character before the first game
    When the user visits the character page
    Then there should be no option to delete their last monster point spend
    
  Scenario: Cannot delete last monster point spend if made before last-but-one game character played (rejected action)
    Given the character has played on a debriefed game
    And there is a monster point spend before the game
    And the user is on the character page
    And the character has played on another debriefed game
    When the user attempts to delete the last monster point spend
    Then the user should be told that they cannot delete a monster point spend from before their last-but-one game
    