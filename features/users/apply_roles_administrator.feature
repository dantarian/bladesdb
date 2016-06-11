Feature: Apply Roles - Administrator
  As an Administrator
  I want to be able to grant and revoke all roles
  So I can manage the membership properly
  
  Background:
  	Given there is an admin user
  	And the user is logged in

  @javascript
  Scenario: User roles - committee add
    Given there is another user
    And the user is on the members page
    When the user grants the committee role to the other user
    Then a roles updated message should be displayed
    And the other user should have the committee role marker

  @javascript
  Scenario: User roles - committee remove
    Given there is a committee user
    And the user is on the members page
    When the user revokes the committee role from the other user
    Then a roles updated message should be displayed
    And the other user should not have the committee role marker

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
