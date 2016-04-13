Feature: Login Rules
	As a user
	I only want to be allowed to log in when in the right state
	So only allowed users can access the website
		
	Scenario: Suspended users cannot log in
		Given there is a suspended user
		When the user logs in
		Then the login page should be displayed
		And the user should see a suspended account message
		
	Scenario: Deleted users cannot log in
		Given there is a deleted user
		When the user logs in
		Then the login page should be displayed
		And the user should see an inactive account message
		
	Scenario: Web-only users can log in
		Given there is a web-only user
		When the user logs in
		Then the home page should be displayed
		And the user should see a successful login message
		
	Scenario: Active users can log in
		Given there is a user
		When the user logs in
		Then the home page should be displayed
		And the user should see a successful login message