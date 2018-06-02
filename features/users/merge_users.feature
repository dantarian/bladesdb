Feature: Merge Users
	As an Administrator
	I want to be able to merge two users
	So that users can have all their stuff

	# Positive scenarios - user should always get these

	@javascript
	Scenario: Merge gives characters
		Given there is a user
		And the user has a character
		And there is another user
		And the other user has a character
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should still have their character
		And the first user should have the second user's character

	@javascript
	Scenario: Merge gives message board posts
		Given there is an OOC message board
		And there is a user
		And there is a message from the user
		And there is another user
		And there is a message from the other user
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should still have their message board post
		And the first user should have the second user's message board post

	@javascript
	Scenario: Merge gives message board posts on closed boards
		Given there is an OOC message board
		And there is a user
		And there is a message from the user
		And there is another user
		And there is a message from the other user
		And the message board is closed
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should have the second user's message board post

	@javascript
	Scenario: Merge gives game applications
		Given there is a game
		And there is a user
		And the user has a game application
		And there is another user
		And the other user has a game application
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should still have their game application
		And the first user should have the second user's game application

	# Negative scenarios - user should never get these

	@javascript
	Scenario: Merge does not give account credentials
		Given there is a user
		And there is another user
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should be able to log in as themselves
		And the first user should not be able to log in as the second user

	@javascript
	Scenario: Merge does not give roles
		Given there is a user
		And there is a first aider user
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should not be a first aider

	# Conditional scenarios - user sometimes gets these

	@javascript
	Scenario: Merge gives game attendance records if the user has none for a game
		Given there is a game
		And there is another game
		And there is a user
		And there is another user
		And the user is a player of the first game
		And the other user is a monster of the first game
		And the other user is a player of the second game
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should still be a player on the first game
		And the first user should be a player on the second game

	@javascript
	Scenario: Merge gives game debrief records if the user has none for a game
		Given there is a game
		And there is another game
		And there is a user
		And there is another user
		And the user is a player of the first game
		And the other user is a monster of the first game
		And the other user is a player of the second game
		And the game has been debriefed
		And the other game has been debriefed
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should still be on the debrief of the first game
		And the first user should be on the debrief of the second game

	@javascript
	Scenario: Merge gives game gming records if the user has none for a game
		Given there is a game
		And there is another game
		And there is a user
		And there is another user
		And the user is a GM for the first game
		And the other user is a GM for the first game
		And the other user is a GM for the second game
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should still be a gm on the first game
		And the first user should be a gm on the second game

	@javascript
	Scenario: Merge does not give monster point declarations if the user has one
		Given there is a user
		And the user has a monster point declaration
		And there is another user
		And the other user has a monster point declaration
		And there is an admin user
		And the admin user is a character ref
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should still have their monster point declaration
		And the first user should not have the second user's monster point declaration

	@javascript
	Scenario: Merge does give monster point declarations if the user has none
		Given there is a user
		And there is another user
		And the other user has a monster point declaration
		And there is an admin user
		And the admin user is a character ref
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should have the second user's monster point declaration

	@javascript
	Scenario: Merge does not give monster point adjustments if the user has any
		Given there is a user
		And the user has a monster point adjustment
		And there is another user
		And the other user has a monster point adjustment
		And there is an admin user
		And the admin user is a character ref
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should not have the second user's monster point adjustment

	@javascript
	Scenario: Merge does give monster point adjustments if the user has none
		Given there is a user
		And there is another user
		And the other user has a monster point adjustment
		And there is an admin user
		And the admin user is a character ref
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should have the second user's monster point adjustment

	@javascript
	Scenario: Merging a GM-created user into a full user
		Given there is a game
		And there is a user
		And there is a GM-created user
		And the other user has a GM-created character
		And the other user has been created for the game
		And the game has been debriefed
		And there is an admin user
		And the admin user is logged in
		When the admin user merges the second user into the first user
		Then the members list should be displayed
		And the second user should no longer exist
		And the first user should have the second user's GM-created character
		And the first user should be on the debrief of the game
