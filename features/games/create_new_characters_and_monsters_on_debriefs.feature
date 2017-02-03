Feature: Create new characters and monsters on debriefs
	As a GM
	I want to be able to create new characters and monsters on my debriefs
	So there is a true record of the debriefed game

	Background:
		Given there is an admin user
		And the user is logged in
		And there is a game
		And the user is a GM for the game
		And the game is in the past
		And the game debrief has been started

	@javascript
	Scenario: Create a character for an existing player
		Given there is another user
		When the GM creates a new character for the player on the debrief
		Then the created character should appear in the debrief for the player
		And the character should appear in the undeclared characters list linked to the player

	@javascript
	Scenario: Create a new player with a new character
		When the GM creates a new player with a new character on the debrief
		Then the created character should appear in the debrief for the created player
		And the character should appear in the undeclared characters list linked to the undeclared player
		And the player should appear in the GM-created members list

	@javascript
	Scenario: Create a new monster
		When the GM creates a new monster on the debrief
		Then the created monster should appear in the debrief
		And the monster should appear in the GM-created members list

	@javascript
	Scenario: Create a new GM
		When the GM creates a new GM on the debrief
		Then the created GM should appear in the debrief
		And the GM should appear in the GM-created members list
