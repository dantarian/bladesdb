Feature: Static Page Access
    As a user
    I only want access to pages I am allowed to see
    So that I don't see things I shouldn't.

Scenario: General page
    Given there is a user
    And there is a general page
    When the user views the page
    Then the page should be displayed
    And the user should not see an edit link

Scenario: General page as a committee user
    Given there is a committee user
	And the user is logged in
    And there is a general page
    When the user views the page
    Then the page should be displayed
    And the user should see an edit link

Scenario: Members-only page as a non-user
    Given there is a user
    And there is a members page
    When the user views the page
    Then the home page should be displayed
    And a page not available message should be displayed

Scenario: Members-only page as a member
    Given there is a user
	And the user is logged in
    And there is a members page
    When the user views the page
    Then the page should be displayed
    And the user should not see an edit link

Scenario: Members-only page as a committee user
    Given there is a committee user
	And the user is logged in
    And there is a members page
    When the user views the page
    Then the page should be displayed
    And the user should see an edit link