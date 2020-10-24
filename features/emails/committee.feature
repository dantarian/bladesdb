@javascript
Feature: Committee E-mails
    As a committee member
    I want to be able to send e-mails to various subsets of the club membership
    So that I can keep the appropriate people informed of club developments

    Scenario Outline: Committee can e-mail holders of various roles
        Given there is a committee user
        And the user is logged in
        And there is another user
        And there is a third user
        And the other user is a <role>
        And the third user is not a <role>
        When the user sends a message to <role>s
        Then the other user should receive the message
        And the message should have the specified subject
        And the message should have the specified content
        And the third user should not receive the message

        Examples:
        | role                         |
        | current member               |
        | web-only user                |
        | experienced GM               |
        | first-aider                  |
        | insurance-responsible person |
