Feature: Character Point Adjustment
	As a user with a character
	I want to be able to request a change to my character's points
	So I can get my number of points right
	
	Background:
		Given there is a user
        And the user has a character
		And the user is logged in
		
	@javascript	
	Scenario: A user can request a positive character point adjustment
		When the user requests a positive character point adjustment
		Then a pending positive character point adjustment should be created
		And a character point adjustment requested message should be displayed
		
	@javascript	
	Scenario: A user can request a negative character point adjustment
		When the user requests a negative character point adjustment
		Then a pending negative character point adjustment should be created
		And a character point adjustment requested message should be displayed
		
	Scenario: An approved adjustment is added to the character points for the user
		Given the character has a character point adjustment
		Then the character's character points should include the character point adjustment
	
	Scenario: An unapproved adjustment is ignored
		Given the character has a pending character point adjustment
		Then the character's character points should not include the character point adjustment
	
	Scenario: A rejected adjustment is ignored
		Given the character has a rejected character point adjustment
		Then the character's character points should not include the character point adjustment
