Feature: Member List - Administrator
  As an Administrator
  I want to be able to delete, suspend, purge and grant roles to members
  So I can manage the membership properly
  
  Background:
  	Given there is an admin user
  	And the user is logged in

  Scenario: All members page - Admin
    Given there is a web-only user
  	And there is a suspended user
  	And there is a deleted user
  	And there is an unconfirmed user
  	And there is an unapproved user
  	When the user goes to the members page
    Then the user should be in the Active Members table
    And the other user should be in the Web-only Members table
    And the user should see all other tables
    And the user should see all user management links
    And the user should see a merge users link
    
  Scenario: Accessing other profile
  	Given there is another user
  	And the user is on the members page
    When the user clicks on the other user's name
    Then the other user's profile should be displayed

  Scenario: User suspension
    Given there is another user
    And the user is on the members page
    When the user suspends the other user
    Then the other user should be in the Suspended table
    And the user should see an unsuspend link

  Scenario: User unsuspension
    Given there is a suspended user
    And the user is on the members page
    When the user unsuspends the other user
    Then the other user should be in the Active Members table
    
  Scenario: User deletion
    Given there is another user
    And the user is on the members page
    When the user deletes the other user
    Then the other user should be in the Deleted table
    And the user should see an undelete link
    And the user should see a purge link

  Scenario: User undeletion
    Given there is a deleted user
    And the user is on the members page
    When the user undeletes the other user
    Then the other user should be in the Active Members table
    
  Scenario: User purge
    Given there is a deleted user
    And the user is on the members page
    When the user purges the other user
    Then the other user should no longer exist

  Scenario: User approval
    Given there is an unapproved user
    And the user is on the members page
    When the user approves the other user 
    Then the other user should be in the Active Members table
    And an approval email should be sent to the other user
    
  Scenario: User rejection
    Given there is an unapproved user
    And the user is on the members page
    When the user rejects the other user 
    Then the other user should be in the Deleted table

  @javascript
  Scenario: User activation email resend
    Given there is an unconfirmed user
  	And the user is on the members page
    When the user resends the activation email for the other user
    Then an activation email message should be displayed
    And an activation email should be sent to the other user
