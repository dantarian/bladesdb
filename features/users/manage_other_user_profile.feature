Feature: Manage Other User Profile
  As an Administrator
  I want to be able to make edits to another's user profile
  So that their details can be updated

	Background:
		Given there is an admin user
		And the user is logged in
		And there is another user

  @javascript
  Scenario: Administrator editing another user’s Name
    When the user updates the other user's name
    Then the new name should be displayed on the other user's profile
    And an other user's profile updated message should be displayed

  @javascript
  Scenario: Administrator editing another user’s Login
    When the user updates the other user's login
    Then the new login should be displayed on the other user's profile
    And an other user's profile updated message should be displayed

  @javascript
  Scenario: Administrator editing another user’s Email
    When the user updates the other user's email
    Then the new email should be displayed on the other user's profile
    And an other user's profile updated message should be displayed

  @javascript
  Scenario: Administrator editing another user’s Mobile Number
    When the user updates the other user's contact number
    Then the new contact number should be displayed on the other user's profile
    And an other user's profile updated message should be displayed

  @javascript
  Scenario: Administrator editing another user’s Emergency Contact Name and Number
    When the user updates the other user's emergency contact
    Then the new emergency contact should be displayed on the other user's profile
    And an other user's profile updated message should be displayed

  @javascript
  Scenario: Administrator editing another user’s Medical Notes
    When the user updates the other user's medical notes
    Then the new medical notes should be displayed on the other user's profile
    And an other user's profile updated message should be displayed

  @javascript
  Scenario: Administrator editing another user’s Food Notes
    When the user updates the other user's food notes
    Then the new food notes should be displayed on the other user's profile
    And an other user's profile updated message should be displayed
    
  @javascript
  Scenario: Administrator editing another user’s General Notes
    When the user updates the other user's notes
    Then the new notes should be displayed on the other user's profile
    And an other user's profile updated message should be displayed
