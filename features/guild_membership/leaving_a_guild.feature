@javascript
Feature: Leaving a Guild
	As a player
	I want my characters to be able to join a Guild
	So they can get the shinies
	
	Background:
		Given there is a user
		And the user is logged in
		And the user has a character
		And there is a Guild
		And the character is a member of the Guild
	
	Scenario: Leaving a Guild
		When the character asks to leave the Guild
		Then an application to leave the Guild should be shown on the character's profile
		And an application to leave message should be displayed
		
	Scenario: Cancelling a Leave request
		Given the character has an application to leave the Guild
		When the character cancels their request to leave the Guild
		Then the old Guild should be shown on the character's profile
		And an application cancelled message should be displayed