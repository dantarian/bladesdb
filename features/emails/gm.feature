@javascript
Feature: GM E-mails
    As a GM
    I want to be able to send e-mails to various subsets of attendees of my game
    So that I can inform the relevant people about details of my game

    Background:
        Given there is a user
        And the user is logged in
        And there is a game
        And the user is a GM for the game

    Scenario: GM can e-mail monsters
        Given there is a monster for the game
        And there is a player for the game
        When the user sends a message to monsters on the game
        Then the monster should receive the message
        And the message to the monster should have the specified subject
        And the message to the monster should have the specified content
        And the player should not receive the message

    Scenario: GM can e-mail players
        Given there is a monster for the game
        And there is a player for the game
        When the user sends a message to players on the game
        Then the player should receive the message
        And the message to the player should have the specified subject
        And the message to the player should have the specified content
        And the monster should not receive the message

    Scenario: GM can e-mail all attendees
        Given there is a monster for the game
        And there is a player for the game
        When the user sends a message to all attendees of the game
        Then the monster should receive the message
        And the player should receive the message
        And the message should have the specified subject
        And the message should have the specified content

    Scenario: GM can include the character refs in an e-mail
        When the user sends a message to monsters on the game including the character refs
        Then the character refs should receive the message

    Scenario: GM can include the committee in an e-mail
        When the user sends a message to monsters on the game including the committee
        Then the committee should receive the message
