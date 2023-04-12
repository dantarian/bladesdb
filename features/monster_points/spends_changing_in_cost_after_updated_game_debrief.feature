@javascript
Feature: Spends changing in cost after a game debrief update
  As a user with a character
  I want to be informed if a change in a past debrief affects my monster point spends
  So that I can make sure my rank is what I expect it to be
  
  Background:
    Given there is a user
    And the user has no joining bonus monster point adjustment
    And the user has 10 monster points available
    And the user has a character
    And there is a game in the past
    And there is a GM for the game
    And the character was played on the game
    And the game has been debriefed
    And there is a Debriefs board

  Scenario: Having spent monster points after a game, the debrief changes giving you fewer points such that your spend is cheaper
	Given the character has 190 character points before the game
	And the character has received 10 character points in the debrief
	And the user bought 1 character point for 3 monster points for the character after the game
	When the GM logs in
	And the GM reopens the debrief for the game
	And the GM changes the character's debrief to give them -1 bonus points
	And the GM closes the debrief for the game
	And the GM logs out
	And the user logs in
	Then the user should have 8 monster points
	And the character should have 200 character points
	And the user should receive an e-mail telling them that their monster point spend has reduced in cost
  
  Scenario: Having spent monster points after a game, the debrief changes giving you fewer points such that your spend is the same cost
	Given the character has 180 character points before the game
	And the character has received 10 character points in the debrief
	And the user bought 1 character point for 2 monster points for the character after the game
	When the GM logs in
	And the GM reopens the debrief for the game
	And the GM changes the character's debrief to give them -1 bonus points
	And the GM closes the debrief for the game
	And the GM logs out
	And the user logs in
	Then the user should have 8 monster points
	And the character should have 190 character points
  
  Scenario: Having spent monster points after a game, the debrief changes giving you more points such that your spend is the same cost
	Given the character has 180 character points before the game
	And the character has received 10 character points in the debrief
	And the user bought 1 character point for 2 monster points for the character after the game
	When the GM logs in
	And the GM reopens the debrief for the game
	And the GM changes the character's debrief to give them 1 bonus point
	And the GM closes the debrief for the game
	And the GM logs out
	And the user logs in
	Then the user should have 8 monster points
	And the character should have 192 character points
  
  Scenario: Having spent monster points after a game, the debrief changes giving you more points such that your spend is more expensive but affordable
	Given the character has 189 character points before the game
	And the character has received 10 character points in the debrief
	And the user bought 1 character point for 2 monster points for the character after the game
	When the GM logs in
	And the GM reopens the debrief for the game
	And the GM changes the character's debrief to give them 1 bonus point
	And the GM closes the debrief for the game
	And the GM logs out
	And the user logs in
	Then the user should have 7 monster points
	And the character should have 201 character points
	And the user should receive an e-mail telling them that their monster point spend has increased in cost
  
  Scenario: Having spent monster points after a game, the debrief changes giving you more points such that your spend is more expensive and unaffordable
	Given the character has 188 character points before the game
	And the character has received 10 character points in the debrief
	And the user bought 4 character points for 10 monster points for the character after the game
	When the GM logs in
	And the GM reopens the debrief for the game
	And the GM changes the character's debrief to give them 1 bonus point
	And the GM closes the debrief for the game
	And the GM logs out
	And the user logs in
	Then the user should have -1 monster points
	And the character should have 203 character points
	And the user should receive an e-mail telling them that their monster point spend has increased in cost
  
  Scenario: Having spent monster points after a game, the debrief is updated but does not change your character point total
  	Given the character has 150 character points before the game
	And the character has received 10 character points in the debrief
	And the user bought 1 character point for 2 monster points for the character after the game
	When the GM logs in
	And the GM reopens the debrief for the game
	And the GM closes the debrief for the game
	And the GM logs out
	And the user logs in
	Then the user should have 8 monster points
	And the character should have 161 character points
  