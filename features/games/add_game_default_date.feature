@javascript
Feature: Adding Games - Default Date
  As a committee member or administrator
  I want to create new games
  So that people can apply to run, play or monster them
  
  Background:
    Given there is an admin user
    And the user is logged in
    
  Scenario: Game creation - no other games
    When the user starts to create a game
    Then the default date is the next Sunday
    
  Scenario: Game creation - single-day game next Sunday
    Given there is a game next Sunday
    When the user starts to create a game
    Then the default date is the Sunday after next
    
  Scenario: Game creation - multi-day game including next Sunday
    Given there is a multi-day game including next Sunday
    When the user starts to create a game
    Then the default date is the Sunday after next
    
  Scenario: Game creation - multi-day game including next Sunday but starting in the past
    Given there is a multi-day game that started yesterday and includes next Sunday
    When the user starts to create a game
    Then the default date is the Sunday after next
    