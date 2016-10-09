@javascript
Feature: Declare Character
    As a user
    I want to be able to declare a character created for me
    So I can play games as that character
    
    Background:
        Given there is a user
        And the user is logged in
        And the user has an undeclared character
        And there is a Guild
    
    Scenario: Declare a character with required values
    	When the user declares a new character with required values
		Then a character declared message should be displayed
		And the character should be created with the basic values
		
	Scenario: Declare a character with a Guild
		When the user declares a new character with a Guild
		Then a character declared message should be displayed
		And the character should be created with the Guild membership
		
	Scenario: Declare a character with a Guild and branch
		Given the Guild has branches 
		When the user declares a new character with a Guild
		Then a character declared message should be displayed
		And the character should be created with the Guild membership
		
	Scenario: Declare a character with a custom title
		When the user declares a new character with a custom title
		Then a character declared message should be displayed
		And the character should be created with the custom title
		
	Scenario: Declare a character with no title
		Given the Guild has rank-based titles
		When the user declares a new character with no title
		Then a character declared message should be displayed
		And the character should be created with no title
		
	Scenario: Cannot declare a character with no name
		When the user tries to declare a new character with no name
		Then a character must have a name message should be displayed
		
	Scenario: Cannot declare a character with null death thresholds
		When the user tries to declare a new character with null death thresholds 
		Then a character must have death thresholds message should be displayed
		
	Scenario: Cannot declare a character with less than zero death thresholds
		When the user tries to declare a new character with negative death thresholds 
		Then a character cannot have less than zero death thresholds message should be displayed
		
	Scenario: Cannot declare a character with too many death thresholds
		When the user tries to declare a new character with more death thresholds than their race allows 
		Then a character cannot have more death thresholds than their race message should be displayed
	
	Scenario: Cannot declare a character with non-numeric death thresholds
		When the user tries to declare a new character with non-numeric death thresholds 
		Then a death thresholds must be a number message should be displayed
		
	Scenario: Cannot declare a character with null character points
		When the user tries to declare a new character with null character points
		Then a character must have character points message should be displayed
		
	Scenario: Cannot declare a character with less than 20 character points
		When the user tries to declare a new character with less than 20 character points
		Then a character cannot have less than 20 character points message should be displayed
		
	Scenario: Cannot declare a character with non-numeric character points
		When the user tries to declare a new character with non-numeric character points
		Then a character points must be a number message should be displayed
	
	Scenario: Cannot declare a character with null money
		When the user tries to declare a new character with null money
		Then a character must have money message should be displayed
		
	Scenario: Cannot declare a character with negative money
		When the user tries to declare a new character with negative money
		Then a character cannot have negative money message should be displayed
		
	Scenario: Cannot declare a character with non-numeric money
		When the user tries to declare a new character with non-numeric money
		Then a money must be a number message should be displayed
		
	Scenario: Cannot declare a character with a Guild and null Guild starting points
		When the user tries to declare a new character with a Guild and null Guild starting points
		Then a character declared message should be displayed
		And the character should be created with the Guild membership
		
	Scenario: Cannot declare a character with a Guild and negative Guild starting points
		When the user tries to declare a new character with a Guild and negative Guild starting points
		Then a character cannot have negative Guild starting points message should be displayed
		
	Scenario: Cannot declare a character with a Guild and non-numeric Guild starting points
		When the user tries to declare a new character with a Guild and non-numeric Guild starting points
		Then a Guild starting points must be a number message should be displayed
		
	Scenario: Cannot declare a character with a Guild and more Guild starting points than character points
		When the user tries to declare a new character with a Guild and more Guild starting points than character points
		Then a Guild starting points must be less than character points message should be displayed