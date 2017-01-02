@javascript
Feature: Manage Character Profile
	As a player
	I want to be able to update my character's profile
	So they display the way I want to.
	
	Background:
		Given there is a user
		And the user is logged in
		And the user has a character
		And there is a Guild
		And the Guild has rank-based titles
		And the character is a member of the Guild
		
	Scenario: Setting a name
		When the user updates their character's name
		Then the updated name should be displayed on the character's profile
		And a character updated message should be displayed
		
	Scenario: Cannot set no name
		When the user tries to update their character's name to nothing
		Then a character must have a name message should be displayed
	
	Scenario: Setting a custom title
		When the user gives their character a custom title
		Then the title should be displayed on the character's profile
		And a character updated message should be displayed
	
	Scenario: Setting no title
		When the user gives their character no title
		Then no title should be displayed on the character's profile
		And a character updated message should be displayed