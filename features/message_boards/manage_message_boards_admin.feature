Feature: Manage Message Boards - Admin
	As an administrator
	I want to be able to maintain IC and OOC message boards
	So that the club can communicate with itself.

	Background: 
		Given there is an admin user
		And the user is logged in
		And the user is on the message boards maintenance page

	Scenario: Creating an OOC board
		When the user creates a new OOC message board
		Then an OOC message board should be created

	Scenario: Creating an IC board
		When the user creates a new IC message board
		Then an IC message board should be created

	Scenario: Editing an OOC board
		Given there is an OOC message board
		When the user edits the message board
		Then the OOC message board should be updated

	Scenario: Editing an IC board
		Given there is an IC message board
		When the user edits the message board
		Then the OOC message board should be updated

	Scenario: Deleting an OOC board
		Given there is an OOC message board
		When the user deletes the message board
		Then a message board deleted message should be displayed
		And the OOC message board should be deleted

	Scenario: Deleting an IC board
		Given there is an IC message board
		When the user deletes the message board
		Then a message board deleted message should be displayed
		And the IC message board should be deleted

	Scenario: Converting an OOC board to an IC board
		Given there is an OOC message board
		When the user converts it to an IC message board
		Then the board should become an IC message board

	Scenario: Converting an IC board to an OOC board
		Given there is an IC message board
		When the user converts it to an OOC message board
		Then the board should become an OOC message board

	Scenario: Closing an OOC board
		Given there is an OOC message board
		When the user marks the board as closed
		Then the board shoud be moved to the closed boards list
		And the user should not be able to post a message to the board

	Scenario: Reopening an OOC board
		Given there is a closed OOC message board
		When the user marks the board as open
		Then the board shoud be moved to the open boards list
		And the user should be able to post a message to the board
		
	Scenario: Closing an IC board
		Given there is an IC message board
		When the user marks the board as closed
		Then the board shoud be moved to the closed boards list
		And the user should not be able to post a message to the board

	Scenario: Reopening an IC board
		Given there is a closed IC message board
		When the user marks the board as open
		Then the board shoud be moved to the open boards list
		And the user should be able to post a message to the board
		
	Scenario: Moving a board up in the list
		Given there is an OOC message board
		And there is an IC message board
		When the user moves the IC board up the list
		Then the IC board should appear above the OOC board
	
	Scenario: Moving a board down in the list
		Given there is an OOC message board
		And there is an IC message board
		When the user moves the OOC board down the list
		Then the IC board should appear above the OOC board