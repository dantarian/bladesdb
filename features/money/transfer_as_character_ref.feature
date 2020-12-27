@javascript
Feature: Money transfers by a character ref
    As a character ref
    I want to transfer money from characters to other characters and NPCs
    So that they can pay for in-world items and resources

    Background:
        Given there is a character ref user
        And there is another user
        And the other user has a character
        And the character has 1 groat
        And the user is logged in

    Scenario: Transfer money from one character to another
        Given the other user has another character
        And the other character has 0 groats
        When the user transfers 1 groat from the character to the other character
        Then the character should have 0 groats
        And the other character should have 1 groat

    Scenario: Transfer money from a character to an NPC
        When the user transfers 1 groat from the character to an NPC
        Then the character should have 0 groats

    Scenario: Transfer money from an NPC to a character
        When the user transfers 1 groat from an NPC to the character
        Then the character should have 2 groats

    Scenario: Cannot transfer money to own character
        Given the user has a character
        When the user tries to transfer 1 groat from the character to their character
        Then the user should be unable to transfer money to their own characters

    Scenario: Cannot transfer more money than the character has
        Given the other user has another character
        When the user transfers 2 groats from the character to the other character
        Then the user should be told they cannot transfer more money than they have
