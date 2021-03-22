@javascript
Feature: Deleting messages
  As a user
  I want to be able to delete a message I have posted
  So that I can clean up my mistakes

  Background:
    Given there is a user
    And the user is logged in
    And there is an OOC message board

  Scenario: User can delete their own messages
    Given there is a message from the user
    When the user deletes the message
    Then the message should not appear on the message board
    And a placeholder should indicate that the message has been deleted
