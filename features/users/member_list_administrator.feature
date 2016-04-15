Feature: Member List - Administrator
  As an Administrator
  I want to be able to delete, suspend, purge and grant roles to members
  So I can manage the membership properly

  @javascript
  Scenario: All members page
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
    And there is a "Pending" table
    And there is a "Deleted" table
    And there is a "GM-Created" table
    And there is a "Merge users" link
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
  Scenario: User deletion and purge
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Active" table
    When I click on the "Delete" link for the "User" with the name "Alice Smith"
    Then the "User" with the name "Alice Smith" is in the "Deleted" table
    And there is no "Delete" link for the "User" with the name "Alice Smith"
    And there is an "Undelete" link for the "User" with the name "Alice Smith"
    And there is a "Purge" link for the "User" with the name "Alice Smith"
    When I click on the "Purge" link for the "User" with the name "Alice Smith"
    Then the "User" with the name "Alice Smith" does not appear on any table

  @javascript
  Scenario: User deletion - user already deleted
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And they are deleted
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Deleted" table
    And there is no "Delete" link for the "User" with the name "Alice Smith"
    And there is an "Undelete" link for the "User" with the name "Alice Smith"
    And there is a "Purge" link for the "User" with the name "Alice Smith"

  @javascript
  Scenario: User undeletion
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And they are deleted
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Deleted" table
    And there is no "Delete" link for the "User" with the name "Alice Smith"
    And there is an "Undelete" link for the "User" with the name "Alice Smith"
    And there is a "Purge" link for the "User" with the name "Alice Smith"
    When I click on the "Undelete" link for the "User" with the name "Alice Smith"
    Then the "User" with the name "Alice Smith" is in the "Active" table
    And there is no "Undelete" link for the "User" with the name "Alice Smith"
    And there is a "Delete" link for the "User" with the name "Alice Smith"

  @javascript
  Scenario: User undeletion - user not deleted
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Active" table
    And there is no "Undelete" link for the "User" with the name "Alice Smith"
    And there is no "Purge" link for the "User" with the name "Alice Smith"
    And there is a "Delete" link for the "User" with the name "Alice Smith"

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

  @javascript
  Scenario: User approval
    Given I am logged in
    And I am an "Administrator" user
    And there is a pending user
    And their name is "Alice Smith"
    And their email is "alice_smith@test.com"
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Pending" table
    When I click on the "Approve" link for the "User" with the name "Alice Smith"
    Then the "User" with the name "Alice Smith" is in the "Active" table
    And "alice_smith@test.com" should receive an email
    When I open the email
    Then I should see "Your account has been approved." in the email body

  @javascript
  Scenario: User confirmation email resend
    Given I am logged in
    And I am an "Administrator" user
    And there is an unconfirmed user
    And their name is "Alice Smith"
    And their email is "alice_smith@test.com"
    When I go to the list users page
    Then the "User" with the name "Alice Smith" is in the "Pending" table
    When I click on the "Resend activation" link for the "User" with the name "Alice Smith"
    Then a success message is displayed saying "Activation e-mail resent."
    And "alice_smith@test.com" should receive an email
    When I open the email
    Then I should see "activate" in the email body

