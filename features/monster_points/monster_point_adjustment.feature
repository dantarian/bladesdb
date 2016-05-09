Feature: Monster Point Adjustment
	As a user
	I want to be able to request a change to my monster points
	So I can get my number of points right
	
	Background:
		Given there is a user
		And the user is logged in
		
	@javascript	
	Scenario: A user can request a positive monster point adjustment
		When the user requests a positive monster point adjustment
		Then a pending positive monster point adjustment should be created
		And a monster point adjustment requested message should be displayed
		
	@javascript	
	Scenario: A user can request a negative monster point adjustment
		When the user requests a negative monster point adjustment
		Then a pending negative monster point adjustment should be created
		And a monster point adjustment requested message should be displayed
		
	@javascript
	Scenario: A user cannot request a monster point adjustment in the future
		When the user attempts to request a monster point adjustment in the future
		Then a monster point adjustment date must be in the past message should be displayed
		
	Scenario: An approved adjustment is added to the monster points for the user
		Given the user has a monster point adjustment
		When the user goes to their monster points page
		Then the user's monster points should include the monster point adjustment
	
	Scenario: An unapproved adjustment is ignored
		Given the user has a pending monster point adjustment
		When the user goes to their monster points page
		Then the user's monster points should not include the monster point adjustment
	
	Scenario: A rejected adjustment is ignored
		Given the user has a rejected monster point adjustment
		When the user goes to their monster points page
		Then the user's monster points should not include the monster point adjustment
		
	Scenario: A user with a pending adjustment cannot create another
		Given the user has a pending monster point adjustment
		When the user attempts to create another monster point adjustment
		Then the user should not be allowed to create another monster point adjustment