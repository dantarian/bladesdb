Feature: First Aid
  A user who has never updated will get a nag message.
  A user with a blank emergency contact will get a nag message.
  A user with blank medical notes will get a nag message.
  A user with blank food notes will get a nag message.
  A user who hasn't updated in the last three months will get a nag message.
  A user cannot view the First Aid Report for a game.
  A web-only user cannot view the First Aid Report for a game.
  A First Aider user can view the First Aid Report for a game.
  A Committee user can view the First Aid Report for a game.
  A GM can view the First Aid Report for their own game.
  An Administrator user can view the First Aid Report for a game.
  The First Aid Report will contain a record for every player and every monster.
  Each record will include their last update date, their emergency contact name and number, their medical notes and their food notes.
  
  @javascript
  Scenario: A user who has never updated will get a nag message.
	Given I am logged in
    And I have never updated my emergency details
    Then there will be a "medical details" message in the sidebar
	
  @javascript
  Scenario: A user with a blank emergency contact will get a nag message.
	Given I am logged in
    And my name is "Bob Jones"
    And I last updated my emergency details "yesterday"
    And my medical notes are "Bees!"
    And my food notes are "Fish!"
    Then there will be a "medical details" message in the sidebar
	
  @javascript
  Scenario: A user with blank medical notes will get a nag message.
	Given I am logged in
    And my name is "Bob Jones"
    And I last updated my emergency details "yesterday"
    And my contact name is "Carla Brown"
    And my contact number is "07976 123456"
    And my food notes are "Fish!"
    Then there will be a "medical details" message in the sidebar
    
  @javascript
  Scenario: A user with blank food notes will get a nag message.
	Given I am logged in
    And my name is "Bob Jones"
    And I last updated my emergency details "yesterday"
    And my contact name is "Carla Brown"
    And my contact number is "07976 123456"
    And my medical notes are "Bees!"
    Then there will be a "medical details" message in the sidebar
    
  @javascript
  Scenario: A user who hasn't updated in the last three months will get a nag message.
	Given I am logged in
    And my name is "Bob Jones"
    And I last updated my emergency details "four months ago"
    And my contact name is "Carla Brown"
    And my contact number is "07976 123456"
    And my medical notes are "Bees!"
    And my food notes are "Fish!"
    Then there will be a "medical details" message in the sidebar
  
  @javascript
  Scenario: Viewing the First Aid Report - normal user
    Given I am logged in
    And there is another user
    And their name is "Alice Smith"
    And they have a character
    And there is a game
    And the character is a player on the game
    When I go to the game page
    Then there is no "First Aid Report" link
    
  @javascript
  Scenario: Viewing the First Aid Report - web-only user
    Given I am logged in
    And I am a "Webonly" user
    And there is another user
    And their name is "Alice Smith"
    And they have a character
    And there is a game
    And the character is a player on the game
    When I go to the game page
    Then there is no "First Aid Report" link
	
  @javascript
  Scenario: Viewing the First Aid Report - First Aider user
    Given I am logged in
    And I am a "Firstaider" user
    And there is another user
    And their name is "Alice Smith"
    And their contact name is "Carla Brown"
    And their contact number is "07976 123456"
    And their medical notes are "Bees!"
    And their food notes are "Fish!"
    And they have a character
    And there is a game
    And the character is a player on the game
    When I go to the game page
    Then there is a "First Aid Report" link
    When I click on the "First Aid Report" link
    Then I go to the First Aid Report for the game
    And the other user is in the "Players" section
    And they have a "Last Updated" record that says "Never"
    And they have an "Emergency Contact" record that says "Carla Brown on 07976 123456"
    And they have a "Medical Notes" record that says "Bees!"
    And they have a "Food Notes" record that says "Fish!"
    And there is a "Print Report" link
	
  @javascript
  Scenario: Viewing the First Aid Report - Committee user
    Given I am logged in
    And I am a "Committee" user
    And there is another user
    And their name is "Alice Smith"
    And their contact name is "Carla Brown"
    And their contact number is "07976 123456"
    And their medical notes are "Bees!"
    And their food notes are "Fish!"
    And they have a character
    And there is a game
    And the character is a player on the game
    When I go to the game page
    Then there is a "First Aid Report" link
    When I click on the "First Aid Report" link
    Then I go to the First Aid Report for the game
    And the other user is in the "Players" section
    And they have a "Last Updated" record that says "Never"
    And they have an "Emergency Contact" record that says "Carla Brown on 07976 123456"
    And they have a "Medical Notes" record that says "Bees!"
    And they have a "Food Notes" record that says "Fish!"
    And there is a "Print Report" link
	
  @javascript
  Scenario: Viewing the First Aid Report - Administrator user
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And their contact name is "Carla Brown"
    And their contact number is "07976 123456"
    And their medical notes are "Bees!"
    And their food notes are "Fish!"
    And they have a character
    And there is a game
    And the character is a player on the game
    When I go to the game page
    Then there is a "First Aid Report" link
    When I click on the "First Aid Report" link
    Then I go to the First Aid Report for the game
    And the other user is in the "Players" section
    And they have a "Last Updated" record that says "Never"
    And they have an "Emergency Contact" record that says "Carla Brown on 07976 123456"
    And they have a "Medical Notes" record that says "Bees!"
    And they have a "Food Notes" record that says "Fish!"
    And there is a "Print Report" link
	
  @javascript
  Scenario: Viewing the First Aid Report - GM
    Given I am logged in
    And my name is "Bob Jones"
    And my contact name is "Carla Brown"
    And my contact number is "07976 123456"
    And my medical notes are "Bees!"
    And my food notes are "Fish!"
    And there is another user
    And their name is "Alice Smith"
    And their contact name is "Carla Brown"
    And their contact number is "07976 123456"
    And their medical notes are "Bees!"
    And their food notes are "Fish!"
    And they have a character
    And there is a game
    And I am a GM for the game
    And the character is a player on the game
    When I go to the game page
    Then there is a "First Aid Report" link
    When I click on the "First Aid Report" link
    Then I go to the First Aid Report for the game
    And the other user is in the "Players" section
    And they have a "Last Updated" record that says "Never"
    And they have an "Emergency Contact" record that says "Carla Brown on 07976 123456"
    And they have a "Medical Notes" record that says "Bees!"
    And they have a "Food Notes" record that says "Fish!"
    And I am in the "Monsters" section
    And I have a "Last Updated" record that says "Never"
    And I have an "Emergency Contact" record that says "Carla Brown on 07976 123456"
    And I have a "Medical Notes" record that says "Bees!"
    And I have a "Food Notes" record that says "Fish!"
    And there is a "Print Report" link
	