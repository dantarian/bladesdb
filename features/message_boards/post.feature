Feature: Posting messages
  As a confirmed user
  I want to be able to post messages to the message boards
  So that I can communicate with other users of the system
  
  Background:
    Given there is a user
    And the user is logged in
    And there is a message board
  
  Scenario:
    When the user posts a message to the board
    Then the message should appear on the message board
    