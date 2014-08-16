Feature: Food
  A GM can assign a caterer to a game
  A caterer can add food notes to a game
  A caterer can add a food option to a game
  An attendee can select that they do not want food on a game that has a caterer
  An attendee can select that they do want food on a game that has a caterer
  An attendee can select a food option on a game with a food option
  
  Scenario: A GM can assign a caterer to a game
	Given I am logged in
	And there is a game
    And I am a GM for the game
    And there is another user
    When I go to the game page
    Then there is a "Food Options" link
    When I click on the "Food Options" link
    Then a "Food Options" dialogue opens
    When I select the other user from the "Caterers" list
    And I click the "Save" button
    Then the other user is listed as a caterer on the game

  Scenario: A caterer can assign food notes to a game
	Given I am logged in
	And there is a game
    And I am a caterer for the game
    When I go to the game page
    Then there is a "Food Options" link
    When I click on the "Food Options" link
    Then a "Food Options" dialogue opens
    When I fill in "Food Notes" with "These are some food notes."
    And I click the "Save" button
    Then I can see the "Food Notes" for the game read "These are some food notes."
    
  Scenario: A caterer can assign food options to a game
	Given I am logged in
	And there is a game
    And I am a caterer for the game
    When I go to the game page
    Then there is a "Food Options" link
    When I click on the "Food Options" link
    Then a "Food Options" dialogue opens
    When I click on the "Add Option" link
    Then a "Food Option" panel is added
    When I select "All" from the "Category" dropdown
    And I select "Breakfast" from the "Subcategory" dropdown
    And I fill in "Food Description" with "Sausages"
    And I click the "Save" button
    
  Scenario: A user can select not to have food on a game with a caterer
	Given I am logged in
	And there is a game
	And there is a caterer for the game
	When I go to the game page
	