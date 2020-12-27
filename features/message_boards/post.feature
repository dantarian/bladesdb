@javascript
Feature: Posting messages
  As a confirmed user
  I want to be able to post messages to the message boards
  So that I can communicate with other users of the system
  
  Background:
    Given there is a user
    And the user is logged in
  
  Scenario: Posting to an OOC message board
    Given there is an OOC message board
    When the user posts a message to the board
    Then the message should appear on the message board
    
  Scenario: Posting to an IC message board as a character
    Given there is an IC message board
    And the user has a character
    When the user posts a message to the board as the character
    Then the message should appear on the message board from the character

  Scenario: Posting to an IC message board as an arbitrary poster
    Given there is an IC message board
    When the user posts a message to the board as an arbitrary poster
    Then the message should appear on the message board from the arbitrary poster
