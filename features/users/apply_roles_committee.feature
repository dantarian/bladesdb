Feature: Apply Roles - Committee
  As an Committee Members
  I want to be able to grant and revoke roles I'm allowed to
  So I can manage the membership properly
  
  Background:
  	Given there is a committee user
  	And the user is logged in

  @javascript
  Scenario: Disallowed roles
    Given there is another user
    And the user is on the members page
    When the user opens the role dialog
    Then the user cannot grant the administrator role
    And the user cannot grant the committee role
    And the user cannot grant the characterref role

  @javascript
  Scenario: User roles - web-only add
    Given there is another user
    And the user is on the members page
    When the user grants the web-only role to the other user
    Then a roles updated message should be displayed
    And the other user should be in the Web-only Members table

  @javascript
  Scenario: User roles - web-only remove
    Given there is a web-only user
  	And the user is on the members page
    When the user revokes the web-only role from the other user
    Then a roles updated message should be displayed
    And the other user should be in the Active Members table
