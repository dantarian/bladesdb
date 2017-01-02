@javascript
Feature: Joining a Guild
	As a player
	I want my characters to be able to join a Guild
	So they can get the shinies
	
	Background:
		Given there is a user
		And the user is logged in
		And the user has a character
		And there is a Guild
	
	Scenario: Joining a Guild from Guildless
		Given the character is Guildless
		When the character asks to join the Guild
		Then an application to join the Guild should be displayed on the character's profile
		And an application to join message should be displayed
	
	Scenario: Joining a Guild from another Guild
		Given the character is a member of the Guild
		And there is another Guild
		When the character asks to join the other Guild
		Then an application to join the new Guild should be displayed on the character's profile
		And an application to join message should be displayed
	
	Scenario: Changing branch within a Guild 
		Given the Guild has branches
		And the character is a member of the last branch of the Guild
		And the Guild has another branch
		When the character asks to join another branch of the Guild
		Then an application to join the new branch should be displayed on the character's profile
		And an application to change branch message should be displayed
		
	Scenario: Cancelling a Join request from Guildless
		Given the character is Guildless
		And the character has an application to join the Guild
		When the character cancels their request to join a Guild
		Then no Guild should be shown on the character's profile
		And an application cancelled message should be displayed
		
	Scenario: Cancelling a Join request from another Guild
		Given the character is a member of the Guild
		And there is another Guild
		And the character has an application to join another Guild
		When the character cancels their request to join a Guild
		Then the old Guild should be shown on the character's profile
		And an application cancelled message should be displayed