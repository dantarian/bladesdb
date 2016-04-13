Feature: Member List
  As an member
  I want to be able to see the member list
  So I can interact with other members

  @javascript
  Scenario: All users page - Non-Admin
    Given I am logged in
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
    And there is no "Suspended" table
    And there is no "Pending" table
    And there is no "Deleted" table
    And there is no "GM-Created" table
    And there are no "Suspend" links
    And there are no "Delete" links
    And there are no "Edit roles" links
    And there is no "Merge users" link
    When I click on the "Alice Smith" link
    Then I am on the "User" profile page for "Alice Smith"