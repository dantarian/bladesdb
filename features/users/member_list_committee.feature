Feature: Member List - Committee
  As a Committee member
  I want to be able to suspend and grant roles to members
  So I can manage the membership properly

  @javascript
  Scenario: All users page - Committee
    Given I am logged in
    And I am an "Administrator" user
    And my name is "Alice Smith"
    And my login is "alice_smith"
    And my email is "alice_smith@test.com"
    And there is another user
    And their name is "Bob Jones"
    And their login is "bob_jones"
    And their email is "bob_jones@test.com"
    And they are a "Webonly" user
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Active" table
    And the "User" with the name "Bob Jones" is in the "Webonly" table
    And there is a "Suspended" table
    And there is no "Pending" table
    And there is no "Deleted" table
    And there is no "GM-Created" table
    And there is no "Merge users" link
    When I click on the "Alice Smith" link
    Then I am on the "User" profile page for "Alice Smith"

  @javascript
  Scenario: User suspension
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Active" table
    When I click on the "Suspend" link for the "User" with the name "Alice Smith"
    Then the "User" with the name "Alice Smith" is in the "Suspended" table
    And there is no "Suspend" link for the "User" with the name "Alice Smith"
    And there is an "Unsuspend" link for the "User" with the name "Alice Smith"

  @javascript
  Scenario: User suspension - user already suspended
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And they are suspended
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Suspended" table
    And there is no "Suspend" link for the "User" with the name "Alice Smith"
    And there is an "Unsuspend" link for the "User" with the name "Alice Smith"

  @javascript
  Scenario: User unsuspension
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And they are suspended
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Suspended" table
    When I click on the "Unsuspend" link for the "User" with the name "Alice Smith"
    Then the "User" with the name "Alice Smith" is in the "Active" table
    And there is no "Unsuspend" link for the "User" with the name "Alice Smith"
    And there is a "Suspend" link for the "User" with the name "Alice Smith"

  @javascript
  Scenario: User unsuspension - user not suspended
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Active" table
    And there is no "Unsuspend" link for the "User" with the name "Alice Smith"
    And there is a "Suspend" link for the "User" with the name "Alice Smith"

  @javascript
  Scenario: User roles - general add
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    When I go to the list users page
    And I click on the "Edit roles" link for the "User" with the name "Alice Smith"
    Then a "Roles for Alice Smith" dialogue opens
    When I check "Committee"
    And I click the "Update" button
    Then a success message is displayed saying "Roles updated"
    And the "User" with the name "Alice Smith" has the "Committee" marker

  @javascript
  Scenario: User roles - general remove
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And they are a "Committee" user
    When I go to the list users page
    And  I click on the "Edit roles" link for the "User" with the name "Alice Smith"
    Then a "Roles for Alice Smith" dialogue opens
    When I uncheck "Committee"
    And I click the "Update" button
    Then a success message is displayed saying "Roles updated"
    And the "User" with the name "Alice Smith" does not have the "Committee" marker

  @javascript
  Scenario: User roles - web-only add
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    When I go to the list users page
    And I click on the "Edit roles" link for the "User" with the name "Alice Smith"
    Then a "Roles for Alice Smith" dialogue opens
    When I check "Webonly"
    And I click the "Update" button
    Then a success message is displayed saying "Roles updated"
    And the "User" with the name "Alice Smith" is in the "Webonly" table

  @javascript
  Scenario: User roles - web-only remove
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And they are a "Webonly" user
    When I go to the list users page
    And I click on the "Edit roles" link for the "User" with the name "Alice Smith"
    Then a "Roles for Alice Smith" dialogue opens
    When I uncheck "Webonly"
    And I click the "Update" button
    Then a success message is displayed saying "Roles updated"
    And the "User" with the name "Alice Smith" is in the "Active" table

