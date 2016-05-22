@javascript
Feature: Spends changing in cost after a game debrief update
  As a user with a character
  I want to be informed if a change in a past debrief affects my monster point spends
  So that I can make sure my rank is what I expect it to be
  
  Background:
    Given there is a user
    And the user is logged in
    And the user has a character
    And there is a game
    And the character was played on the game

  Scenario: Having spent monster points after a game, the debrief changes giving you fewer points such that your spend is cheaper
  
  Scenario: Having spent monster points after a game, the debrief changes giving you fewer points such that your spend is the same cost
  
  Scenario: Having spent monster points after a game, the debrief changes giving you more points such that your spend is the same cost
  
  Scenario: Having spent monster points after a game, the debrief changes giving you more points such that your spend is more expensive but affordable
  
  Scenario: Having spent monster points after a game, the debrief changes giving you more points such that your spend is more expensive and unaffordable
  
  Scenario: Having spent monster points after a game, the debrief is updated but does not change your character point total
  