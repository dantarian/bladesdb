Feature: User Merge
  Administrators can merge users
  Non-administrators cannot merge users
  The primary merged user remains and the secondary is deleted
  The primary user retains their characters
  The primary user retains their game attendance requests
  The primary user retains their debriefs
  The primary user retains their GMed games
  The primary user retains their monster point declaration
  The primary user retains their monster point adjustments
  The primary user retains their account credentials
  The primary user retains their records of message board visits
  The primary user retains their GMed campaigns
  The primary user retains their records of being a caterer
  The primary user retains their food requests
  The primary user retains their game applications
  The primary user retains their message board posts
  The primary user retains their permissions
  The primary user gains the characters of the secondary user
  The primary user gains the game attendance requests of the secondary user unless the primary user already has an attendance request for that game
  The primary user gains the debriefs of the secondary user unless the primary user already has a debrief of that type for that game
  The primary user gains the GMed games of the secondary user unless the primary user is already a GM for that game
  The primary user does not gain the monster point declaration of the secondary user - it will be deleted
  The primary user does not gain the monster point adjustments of the secondary user - they will be deleted
  The primary user does not gain the account credentials of the secondary user - they will be deleted
  The primary user does not gain records of message board visits of the secondary user - they will be deleted
  The primary user gains the GMed campaigns of the secondary user unless the primary user is already a GM for that campaign
  The primary user gains the records of being a caterer of the secondary user unless the primary user is already a caterer for that game
  The primary user gains the food requests of the secondary user unless the primary user already has a food request for that game
  The primary user gains the game applications of the secondary user
  The primary user gains the message board posts of the secondary user
  The primary user does not gain the permissions of the secondary user - they will be deleted
  
  Scenario: Administrators can merge users
    Given I am logged in
    And I am an "Administrator" user
	And there is another user
	And there is a third user
	When I go to the list users page
	Then there is a "Merge users" link
	When I click on the "Merge users" link
	Then the merge users page is displayed
	
  Scenario: Non-administrators cannot merge users
    Given I am logged in
    And I am a "Committee" user
    And I am a "CharacterRef" user
    And I am a "Firstaider" user
    And I am an "ExperiencedGM" user
    And I am an "Insurance" user
    And there is another user
    And there is a third user
    When I go to the list users page
    Then there is no "Merge users" link
    
  Scenario: The primary merged user remains and the secondary is deleted
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And there is a third user
    When I merge the users
    Then the other user has not been deleted
    But the third user has been deleted
    
  Scenario: The primary user retains their characters
    Given there are two users
    And the first user has a character
    When the users are merged
    Then the user has a character
  
  Scenario: The primary user retains their game attendance requests
    Given there are two users
    And the first user has a game attendance request
    When the users are merged
    Then the user has a game attendance request
  
  Scenario: The primary user retains their debriefs
  
  Scenario: The primary user retains their GMed games
  
  Scenario: The primary user retains their monster point declaration
  
  Scenario: The primary user retains their monster point adjustments
  
  Scenario: The primary user retains their account credentials
  
  Scenario: The primary user retains their records of message board visits
  
  Scenario: The primary user retains their GMed campaigns
  
  Scenario: The primary user retains their records of being a caterer
  
  Scenario: The primary user retains their food requests
  
  Scenario: The primary user retains their game applications
  
  Scenario: The primary user retains their message board posts
  
  Scenario: The primary user retains their permissions
  
  Scenario: The primary user gains the characters of the secondary user
  
  Scenario: The primary user gains the game attendance requests of the secondary user unless the primary user already has an attendance request for that game
  
  Scenario: The primary user gains the debriefs of the secondary user unless the primary user already has a debrief of that type for that game
  
  Scenario: The primary user gains the GMed games of the secondary user unless the primary user is already a GM for that game
  
  Scenario: The primary user does not gain the monster point declaration of the secondary user - it will be deleted
  
  Scenario: The primary user does not gain the monster point adjustments of the secondary user - they will be deleted
  
  Scenario: The primary user does not gain the account credentials of the secondary user - they will be deleted
  
  Scenario: The primary user does not gain records of message board visits of the secondary user - they will be deleted
  
  Scenario: The primary user gains the GMed campaigns of the secondary user unless the primary user is already a GM for that campaign
  
  Scenario: The primary user gains the records of being a caterer of the secondary user unless the primary user is already a caterer for that game
  
  Scenario: The primary user gains the food requests of the secondary user unless the primary user already has a food request for that game
  
  Scenario: The primary user gains the game applications of the secondary user
  
  Scenario: The primary user gains the message board posts of the secondary user
  
  Scenario: The primary user does not gain the permissions of the secondary user - they will be deleted
  