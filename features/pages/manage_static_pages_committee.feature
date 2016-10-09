Feature: Manage Static Pages - Committee
    As a committee member
    I want to be able to maintain website content
    So that the website stays up to date

    Background: 
        Given there is a committee user
        And the user is logged in

    Scenario: Creating a page
        When the user creates a static page
        Then a page created message should be displayed
		And the new page should be displayed

    Scenario: Previewing a page
        When the user previews a static page
        Then a preview of the page should be displayed
        
    Scenario: Cannot create a duplicate page
    	Given there is a general page
    	When the user creates a static page with the same title
    	Then a duplicate page title message is displayed
    	
    Scenario: Cannot create an empty page
    	When the user creates a static page with no content
    	Then an empty page message is displayed

    Scenario: Editing a page through the menu
    	Given there is a general page
        When the user edits a static page
        Then a page updated message should be displayed		
		And the updated page should be displayed

    Scenario: Editing a page through the page
    	Given there is a general page
        When the user edits a static page through the page
        Then a page updated message should be displayed
		And the updated page should be displayed
	
	@javascript
    Scenario: Deleting a page
    	Given there is a general page
        When the user deletes a static page
        Then a page deleted message should be displayed
		And the page should be deleted
	
	@javascript
    Scenario: Deleting the home page
        When the user deletes the home page
        Then a home page cannot be deleted message should be displayed
		And the home page should not be deleted