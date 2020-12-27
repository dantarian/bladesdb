@javascript
Feature: Adding Games - GMs
  As a committee member or administrator
  I want to create new games
  So that people can apply to run, play or monster them
  
  Background:
    Given there is an admin user
    And the user is logged in

  Scenario: GM list - normal users present
    Given there is another user
    When the user starts to create a game
    Then the other user should be in the list of available GMs

  Scenario: GM list - web-only users not present
    Given there is a web-only user
    When the user starts to create a game
    Then the web-only user should not be in the list of available GMs

  Scenario: GM list - suspended users not present
    Given there is a suspended user
    When the user starts to create a game
    Then the suspended user should not be in the list of available GMs

  Scenario: GM list - unapproved users not present
    Given there is an unapproved user
    When the user starts to create a game
    Then the unapproved user should not be in the list of available GMs

  Scenario: GM list - unconfirmed users not present
    Given there is an unconfirmed user
    When the user starts to create a game
    Then the unconfirmed user shoud not be in the list of available GMs

  Scenario: GM list - deleted users not present
    Given there is a deleted user
    When the user starts to create a game
    Then the deleted user shoud not be in the list of available GMs
