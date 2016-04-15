Feature: View User Profiles
  As a user
  I want to be able to see the fields on a user profile appropriate to my role
  So I know only what I need to know

  Scenario: Viewing own profile page
    Given there is a user
    And the user is logged in
    And the user has filled in all their details
    When the user goes to their profile page
    Then they should see all their own profile fields
    And they should see their own profile edit links
    And they should see their own change password link
    
  Scenario: User checking P:M ratio
  	Given there is a user
    And the user is logged in
  	When the user goes to their profile page
  	Then the user's P:M ratio should be displayed in the sidebar
  	And the user's statistics should be displayed

  Scenario: Viewing another user’s profile page - general
    Given there is a user
    And the user is logged in
    And there is another user
    And the other user has filled in all their details
    When the user goes to the other user's profile page
    Then they should see core profile fields
    And they should not see any profile edit links
    And they should not see a change password link

  Scenario: Viewing another user’s profile page - Administrator
    Given there is an admin user
    And the user is logged in
    And there is another user
    And the other user has filled in all their details
    When the user goes to the other user's profile page
    Then they should see all profile fields
    And they should see the other user's profile edit links
    And they should not see a change password link

  Scenario: Viewing another user’s profile page - Committee
    Given there is a committee user
    And the user is logged in
    And there is another user
    And the other user has filled in all their details
    When the user goes to the other user's profile page
    Then they should see committee relevant profile fields
    And they should not see any profile edit links
    And they should not see a change password link
    
  Scenario: Viewing another user’s profile page - Character Ref
    Given there is a character ref user
    And the user is logged in
    And there is another user
    And the other user has filled in all their details
    When the user goes to the other user's profile page
    Then they should see character-ref relevant profile fields
    And they should not see any profile edit links
    And they should not see a change password link

  Scenario: Viewing another user’s profile page - First aider
    Given there is a first aider user
    And the user is logged in
    And there is another user
    And the other user has filled in all their details
    When the user goes to the other user's profile page
    Then they should see first-aider relevant profile fields
    And they should not see any profile edit links
    And they should not see a change password link
    
  Scenario: Viewing another user’s profile page - Web only
    Given there is a web-only user
    And the user is logged in
    And there is another user
    When the user goes to the other user's profile page
    Then the user's profile should be displayed

  Scenario: Viewing another user’s profile page - current GM
    Given there is a user
    And the user is logged in
    And there is another user
    And the other user has filled in all their details
    And there is a game
    And the user is a GM for the game
    And the other user is a player of the game
    When the user goes to the other user's profile page
    Then they should see gm relevant profile fields
    And they should not see any profile edit links
    And they should not see a change password link