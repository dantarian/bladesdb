Feature: First Aid Report
	As a First Aider
	I want to be able to download a report of all medical notes for everyone on a given game
	So I can make sure that they are cared for properly if injured
	
	Background:
		Given there is a first aider user
		And the user is logged in
	
	@javascript
	Scenario: A first aider downloads a report for people with their details in date
		Given the user has filled in all their details
		And there is a game
		And there is a GM for the game
		And there is a player for the game
		And there is a monster for the game
		And the GM has set their medical details
		And the player has set their medical details
		And the monster has set their medical details
		When the user clicks on the first aid report link on the game
		Then the first aid report should be displayed in a new tab
		And the medical details of the GM should be present
		And the medical details of the player should be present
		And the medical details of the monster should be present
		But the medical details of the first aider should not be present
		
	@javascript
	Scenario: A user hasn't filled in their details
		Given there is a game
		And there is a GM for the game
		And the GM has not set their medical details
		When the user clicks on the first aid report link on the game
		Then the first aid report should be displayed in a new tab
		And the medical details of the GM should be out of date