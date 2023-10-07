Feature: Monster Point Declaration
	As a user
	I want to be able to declare my starting monster points
	So I can set an arbitrary starting date and points

	Background:
		Given there is a user
    And the user has no joining bonus monster point adjustment
		And the user is logged in

	@javascript
	Scenario: A user can declare a starting number of monster points
		When the user declares their starting monster points
		Then a pending monster point declaration should be created
		And a monster point declaration made message should be displayed

	@javascript
	Scenario: A user cannot declare a negative starting number of monster points
		When the user attempts to declare a negative starting number of monster points
		Then a negative monster point declaration not allowed message should be displayed

	@javascript
	Scenario: A user cannot declare a starting number of monster points in the future
		When the user attempts to declare a starting number of monster points in the future
		Then a monster point declaration date must be in the past message should be displayed

	Scenario: An approved declaration sets the base monster points for the user
		Given the user has a monster point declaration
		When the user goes to their monster points page
		Then the user's base monster points should be set from the monster point declaration

	Scenario: An unapproved declaration is ignored
		Given the user has a pending monster point declaration
		When the user goes to their monster points page
		Then the user's base monster points should not be set from the monster point declaration

	Scenario: A rejected declaration is ignored
		Given the user has a rejected monster point declaration
		When the user goes to their monster points page
		Then the user's base monster points should not be set from the monster point declaration

	@javascript
	Scenario: A user can edit a rejected declaration
		Given the user has a rejected monster point declaration
		When the user edits their monster point declaration
		And a monster point declaration updated message should be displayed

	@javascript
	Scenario: A user cannot edit a pending declaration
		Given the user has a pending monster point declaration
		When the user attempts to edit their monster point declaration
		Then the user should not be allowed to edit the monster point declaration

	Scenario: A user with an approved declaration cannot create another
		Given the user has a monster point declaration
		When the user attempts to create another monster point declaration
		Then the user should not be allowed to create another monster point declaration

	Scenario: A user with a pending declaration cannot create another
		Given the user has a pending monster point declaration
		When the user attempts to create another monster point declaration
		Then the user should not be allowed to create another monster point declaration

	Scenario: A user with a rejected declaration cannot create another
		Given the user has a rejected monster point declaration
		When the user attempts to create another monster point declaration
		Then the user should not be allowed to create another monster point declaration
