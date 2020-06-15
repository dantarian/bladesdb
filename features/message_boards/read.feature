Feature: Reading message boards
  As a user
  I want to be able to read messages on the message boards
  So that I can stay up-to-date with what's happening in the club

  Background:
    Given there is an OOC message board
    And there is an IC message board
    And there is a user
    And the user is logged in

  Scenario: Message boards track unread messages
    Given there is a message on the OOC message board
    And there is a message on the IC message board
    When the user views the list of message boards
    Then there should be 1 unread message for the OOC message board
    And there should be 1 unread message for the IC message board

  Scenario: Visiting a board with an unread message marks it read
    Given there is a message on the OOC message board
    And there is a message on the IC message board
    When the user visits the OOC message board
    And the user views the list of message boards
    Then there should be 0 unread messages for the OOC message board
    And there should be 1 unread message for the IC message board    

  Scenario: User can mark all boards as read
    Given there is a message on the OOC message board
    And there is a message on the IC message board
    When the user marks the boards as read
    And the user views the list of message boards
    Then there should be 0 unread messages for the OOC message board
    And there should be 0 unread messages for the IC message board

