@javascript
Feature: Money transfers by a character
    As a player
    I want to transfer money from my characters to other characters and NPCs
    So that I can pay for in-world items and resources

    Background:
        Given there is a user
        And the user has a character
        And the character has 1 groat
        And the user is logged in

    Scenario: Transfer money from one character to another
        Given there is another user
        And the other user has a character
        And the other character has 0 groats
        When the user transfers 1 groat from the character to the other user's character
        Then the character should have 0 groats
        When the user logs out
        And the other user logs in
        And the other character should have 1 groat

    Scenario: Transfer money from one character to an NPC
        When the user transfers 1 groat from the character to an NPC
        Then the character should have 0 groats

    Scenario: Cannot transfer money between own characters
        Given the user has another character
        When the user tries to transfer 1 groat from the character to the other character
        Then the user should be unable to transfer money between their own characters

    Scenario: Cannot transfer more money than the character has
        Given there is another user
        And the other user has a character
        When the user transfers 2 groats from the character to the other user's character
        Then the user should be told they cannot transfer more money than they have
