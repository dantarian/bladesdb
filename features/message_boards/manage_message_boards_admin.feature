Feature: Manage Message Boards - Admin
	As an administrator
	I want to be able to maintain IC and OOC message boards
	So that the club can communicate with itself.

	Background: 
		Given there is an admin user
		And the user is logged in

	@javascript
	Scenario: Creating an OOC board
		When the user creates a new OOC message board
		Then an OOC message board should be created

	@javascript
	Scenario: Creating an IC board
		When the user creates a new IC message board
		Then an IC message board should be created

	@javascript
	Scenario: Editing an OOC board
		Given there is an OOC message board
		When the user edits the OOC message board
		Then the OOC message board should be updated

	@javascript
	Scenario: Editing an IC board
		Given there is an IC message board
		When the user edits the IC message board
		Then the IC message board should be updated

	@javascript
	Scenario: Deleting an OOC board
		Given there is an OOC message board
		When the user deletes the OOC message board
		Then the OOC message board should be deleted

	@javascript
	Scenario: Deleting an IC board
		Given there is an IC message board
		When the user deletes the IC message board
		Then the IC message board should be deleted

	@javascript
	Scenario: Converting an OOC board to an IC board
		Given there is an OOC message board
		When the user converts it to an IC message board
		Then the board should become an IC message board

	@javascript
	Scenario: Converting an IC board to an OOC board
		Given there is an IC message board
		When the user converts it to an OOC message board
		Then the board should become an OOC message board

	@javascript
	Scenario: Closing an OOC board
		Given there is an OOC message board
		When the user marks the board as closed
		Then the OOC board should be moved to the closed boards list
		And the user should not be able to post a message to the OOC board

	@javascript
	Scenario: Reopening an OOC board
		Given there is a closed OOC message board
		When the user marks the board as open
		Then the OOC board should be moved to the open boards list
		And the user should be able to post a message to the OOC board
		
	@javascript
	Scenario: Closing an IC board
		Given there is an IC message board
		When the user marks the board as closed
		Then the IC board should be moved to the closed boards list
		And the user should not be able to post a message to the IC board

	@javascript
	Scenario: Reopening an IC board
		Given there is a closed IC message board
		When the user marks the board as open
		Then the IC board should be moved to the open boards list
		And the user should be able to post a message to the IC board
		
	@javascript
	Scenario: Moving a board up in the list
		Given there is an OOC message board
		And there is another OOC message board
		And there is an IC message board
		When the user moves the IC board up the list
		Then the IC board should appear between the OOC boards
	
	@javascript
	Scenario: Moving a board down in the list
		Given there is an OOC message board
		And there is another OOC message board
		And there is an IC message board
		When the user moves the OOC board down the list
		Then the OOC board should appear between the other OOC and IC boards