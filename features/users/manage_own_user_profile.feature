Feature: Manage Own User Profile
  As a user
  I want to be able to make edits to my user profile
  So that my details can be updated
  
  Background:
  	Given there is a user
    And the user is logged in

  @javascript
  Scenario: User editing own Name - unique value
    When the user updates their name
    Then the new name should be displayed on their profile
    And a profile updated message should be displayed
    
  @javascript
  Scenario: User editing own Name - non-unique value
    Given there is another user
    When the user updates their name to that of the other user
    Then a name already in use message should be displayed

  @javascript
  Scenario: User editing own Login - unique value
    When the user updates their login
    Then the new login should be displayed on their profile
    And a profile updated message should be displayed

  @javascript
  Scenario: User editing own Login - non-unique value
    Given there is another user
    When the user updates their login to that of the other user
    Then a login already in use message should be displayed
  
  @javascript
  Scenario: User editing own Email - unique value
    When the user updates their email
    Then the new email should be displayed on their profile
    And a profile updated message should be displayed

  @javascript
  Scenario: User editing own Email - non-unique value
    Given there is another user
    When the user updates their email to that of the other user
    Then an email already in use message should be displayed
  
  Scenario: User changing own password
    When the user changes their password
    Then the user's profile should be displayed
    And a successful password change message should be displayed 
  
  Scenario: User changing own password - mismatch
    When the user changes their password incorrectly
    Then a password mismatch message should be displayed
  
  @javascript
  Scenario: User editing own Contact Number
    When the user updates their contact number
    Then the new contact number should be displayed on their profile
    And a profile updated message should be displayed

  @javascript
  Scenario: User editing own Emergency Contact Name and Number
    When the user updates their emergency contact
    Then the new emergency contact should be displayed on their profile
    And a profile updated message should be displayed

  @javascript
  Scenario: User editing own Medical Notes
    When the user updates their medical notes
    Then the new medical notes should be displayed on their profile
    And a profile updated message should be displayed

  @javascript
  Scenario: User editing own Food Notes
    When the user updates their food notes
    Then the new food notes should be displayed on their profile
    And a profile updated message should be displayed
    
  @javascript
  Scenario: User editing own General Notes
    When the user updates their notes
    Then the new notes should be displayed on their profile
    And a profile updated message should be displayed
