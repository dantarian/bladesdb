Feature: Create a Character
	As a player
	I want to be able to create a character
	So I can play games.
	
	Background:
		Given there is a user
		And the user is logged in
		And there is a Guild
	
	@javascript	
	Scenario: Create a new character with required values
		When the user creates a new character with required values
		Then a character created message should be displayed
		And the character should be created with the basic values
	
	@javascript
	Scenario: Create a new character with a Guild
		When the user creates a new character with a Guild
		Then a character created message should be displayed
		And the character should be created with the Guild membership
		
	@javascript
	Scenario: Create a new character with a Guild with branches
		Given the Guild has branches 
		When the user creates a new character with a Guild and branch
		Then a character created message should be displayed
		And the character should be created with the Guild and branch membership
	
	@javascript
	Scenario: Create a new character with a custom title
		When the user creates a new character with a custom title
		Then a character created message should be displayed
		And the character should be created with the custom title
		
	@javascript
	Scenario: Create a new character with no title
		Given the Guild has rank-based titles
		When the user creates a new character with no title
		Then a character created message should be displayed
		And the character should be created with no title
		
	@javascript
	Scenario: Cannot create a character with no name
		When the user tries to create a new character with no name
		Then a character must have a name message should be displayed