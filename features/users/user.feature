Feature: User
  Users can view their own profile page.
  Users can edit their Name.
  Users can edit their Login and Email to a new unique value.
  Users can edit their Mobile Number.
  Users can edit their Emergency Contact Name and Number.
  Users can edit their Medical Notes.
  Users can edit their Food Notes.
  Users can edit their General Notes.
  Users can change their own password.
  Users can view the profile pages of others.
  Users cannot edit another user’s Login, Name and Email.
  Users cannot view or edit another user’s Mobile Number.
  Users cannot view or edit another user’s Emergency Contact Name and Number.
  Users cannot view or edit another user’s Medical Notes.
  Users cannot view or edit another user’s Food Notes.
  Users cannot edit another user’s General Notes.
  Users cannot change another user’s password.
  An Administrator user can edit another user’s Login, Name and Email.
  An Administrator user can view and edit any user’s Mobile Number.
  An Administrator user can view and edit any user’s Emergency Contact Name and Number.
  An Administrator user can view and edit any user’s Medical Notes.
  An Administrator user can view and edit any user’s Food Notes.
  An Administrator user can edit any user’s General Notes.
  A Committee user can view any user’s Mobile Number.
  A Committee user can view any user’s Emergency Contact Name and Number.
  A Committee user can view any user’s Medical Notes.
  A Committee user can view any user’s Food Notes.
  A First Aider user can view any user’s Emergency Contact Name and Number.
  A First Aider user can view any user’s Medical Notes.
  A First Aider user can view any user’s Food Notes.

  Scenario: Viewing own profile page
    Given I am logged in
    And my name is "Alice Smith"
    When I go to my profile page
    Then I can see my "Name" field
    And I can see my "Name" is "Alice Smith"
    And I can see my "Login" field
    And I can see my "Email" field
    And I can see my "Joined Date" field
    And I can see my "Roles" field
    And I can see my "Mobile Number" field
    And I can see my "Emergency Contact" field
    And I can see my "Medical Notes" field
    And I can see my "Food Notes" field
    And I can see my "General Notes" field
    And I can see my "Statistics" section
    And I can see my "Last Ten Debrief Comments" section

  Scenario: Viewing another user’s profile page - general
    Given I am logged in
    And there is another user
    And their name is "Alice Smith"
    When I go to their profile page
    Then I can see their "Name" field
    And I can see their "Name" is "Alice Smith"
    And I can see their "Email" field
    And I can see their "Joined Date" field
    And I can see their "Roles" field
    And I can see their "General Notes" field
    And I can see their "Statistics" section
    And there are no "Edit" links
    And there is no "Change Password" link

  Scenario: Viewing another user’s profile page - Administrator
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    When I go to their profile page
    Then I can see their "Name" field
    And I can see their "Name" is "Alice Smith"
    And I can see their "Login" field
    And I can see their "Email" field
    And I can see their "Joined Date" field
    And I can see their "Roles" field
    And I can see their "Mobile Number" field
    And I can see their "Emergency Contact" field
    And I can see their "Medical Notes" field
    And I can see their "Food Notes" field
    And I can see their "General Notes" field
    And I can see their "Statistics" section
    And I can see their "Last Ten Debrief Comments" section
    And there is no "Change Password" link

  Scenario: Viewing another user’s profile page - Committee
    Given I am logged in
    And I am a "Committee" user
    And there is another user
    And their name is "Alice Smith"
    When I go to their profile page
    Then I can see their "Name" field
    And I can see their "Name" is "Alice Smith"
    And I can see their "Email" field
    And I can see their "Joined Date" field
    And I can see their "Roles" field
    And I can see their "Mobile Number" field
    And I can see their "Emergency Contact" field
    And I can see their "Medical Notes" field
    And I can see their "Food Notes" field
    And I can see their "General Notes" field
    And I can see their "Statistics" section
    And I can see their "Last Ten Debrief Comments" section
    And there are no "Edit" links
    And there is no "Change Password" link

  Scenario: Viewing another user’s profile page - First aider
    Given I am logged in
    And I am a "Firstaider" user
    And there is another user
    And their name is "Alice Smith"
    When I go to their profile page
    Then I can see their "Name" field
    And I can see their "Name" is "Alice Smith"
    And I can see their "Email" field
    And I can see their "Joined Date" field
    And I can see their "Roles" field
    And I can see their "Emergency Contact" field
    And I can see their "Medical Notes" field
    And I can see their "Food Notes" field
    And I can see their "General Notes" field
    And I can see their "Statistics" section
    And there are no "Edit" links
    And there is no "Change Password" link
    
  Scenario: Viewing another user’s profile page - Web only
    Given I am logged in
    And I am a "Webonly" user
    And my name is "Bob Jones"
    And there is another user
    And their name is "Alice Smith"
    When I go to their profile page
    Then I can see my "Name" field
    And I can see my "Name" is "Bob Jones"

  @javascript
  Scenario: Viewing another user’s profile page - current GM
    Given I am logged in
    And there is another user
    And their name is "Alice Smith"
    And they have a character
    And there is a game
    And I am a GM for the game
    And the character is a player on the game
    When I go to their profile page
    Then I can see their "Name" field
    And I can see their "Name" is "Alice Smith"
    And I can see their "Email" field
    And I can see their "Joined Date" field
    And I can see their "Roles" field
    And I can see their "Emergency Contact" field
    And I can see their "Medical Notes" field
    And I can see their "Food Notes" field
    And I can see their "General Notes" field
    And I can see their "Statistics" section
    And I can see their "Last Ten Debrief Comments" section
    And there are no "Edit" links
    And there is no "Change Password" link

  @javascript
  Scenario: User editing own Name
    Given I am logged in
    And my name is "Alice Smith"
    When I go to my profile page
    Then I can see my "Name" field
    When I click on the "Edit" link for "Name"
    Then an "Edit Name" dialogue opens
    When I fill in "Name" with "Bob Jones"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated."
    And I can see my "Name" is "Bob Jones"

  @javascript
  Scenario: User editing another user’s Name - Administrator
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    When I go to their profile page
    Then I can see their "Name" field
    When I click on the "Edit" link for "Name"
    Then an "Edit Name" dialogue opens
    When I fill in "Name" with "Bob Jones"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated for Bob Jones."
    And I can see their "Name" is "Bob Jones"

  @javascript
  Scenario: User editing own Login - unique value
    Given I am logged in
    And my login is "alice_smith"
    And there is another user
    And their login is "bob_jones"
    When I go to my profile page
    Then I can see my "Login" field
    When I click on the "Edit" link for "Login"
    Then an "Edit Login" dialogue opens
    When I fill in "Login" with "carla_brown"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated."
    And I can see my "Login" is "carla_brown"

  @javascript
  Scenario: User editing own Login - non-unique value
    Given I am logged in
    And my login is "alice_smith"
    And there is another user
    And their login is "bob_jones"
    When I go to my profile page
    Then I can see my "Login" field
    When I click on the "Edit" link for "Login"
    Then an "Edit Login" dialogue opens
    When I fill in "Login" with "bob_jones"
    And I click the "Save" button
    Then a dialogue error message is displayed saying "Failed to save user The following problems prevented the user from being saved: Username has already been taken"

  @javascript
  Scenario: User editing another user’s Login - Administrator
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And their login is "alice_smith"
    When I go to their profile page
    Then I can see their "Login" field
    When I click on the "Edit" link for "Login"
    Then an "Edit Login" dialogue opens
    When I fill in "Login" with "bob_jones"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated for Alice Smith."
    And I can see their "Login" is "bob_jones"

  @javascript
  Scenario: User editing own Email - unique value
    Given I am logged in
    And my email is "alice_smith@test.com"
    And there is another user
    And their email is "bob_jones@test.com"
    When I go to my profile page
    Then I can see my "Email" field
    When I click on the "Edit" link for "Email"
    Then an "Edit Email" dialogue opens
    When I fill in "Email" with "carla_brown@test.com"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated."
    And I can see my "Email" is "carla_brown@test.com"

  @javascript
  Scenario: User editing own Email - non-unique value
    Given I am logged in
    And my email is "alice_smith@test.com"
    And there is another user
    And their email is "bob_jones@test.com"
    When I go to my profile page
    Then I can see my "Email" field
    When I click on the "Edit" link for "Email"
    Then an "Edit Email" dialogue opens
    When I fill in "Email" with "bob_jones@test.com"
    And I click the "Save" button
    Then a dialogue error message is displayed saying "Failed to save user The following problems prevented the user from being saved: Email has already been taken"


  @javascript
  Scenario: User editing another user’s Email - Administrator
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And their email is "alice_smith@test.com"
    When I go to their profile page
    Then I can see their "Email" field
    When I click on the "Edit" link for "Email"
    Then an "Edit Email" dialogue opens
    When I fill in "Email" with "carla_brown@test.com"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated for Alice Smith."
    And I can see their "Email" is "carla_brown@test.com"
  
  @rake_test
  Scenario: User changing own password
    Given I am logged in
    When I go to my profile page
    And I click on the "Change password" link
    Then I go to the Change Password page
    When I fill in "Current password" with "Passw0rd"
    And I fill in "New password" with "Pa55word"
    And I fill in "Password confirmation" with "Pa55word"
    And I click the "Update" button
    Then a success message is displayed saying "You updated your account successfully."
  
  @rake_test
  Scenario: User changing own password - mismatch
    Given I am logged in
    When I go to my profile page
    And I click on the "Change password" link
    Then I go to the Change Password page
    When I fill in "Current password" with "Passw0rd"
    And I fill in "New password" with "Pa55word"
    And I fill in "Password confirmation" with "Password"
    And I click the "Update" button
    Then an error message is displayed saying "1 error prevented this user from being saved: Password confirmation doesn't match Password"
  
  @javascript
  Scenario: User editing own Mobile Number
    Given I am logged in
    And my mobile number is "07976 123456"
    When I go to my profile page
    Then I can see my "Mobile Number" field
    When I click on the "Edit" link for "Mobile Number"
    Then an "Edit Mobile Number" dialogue opens
    When I fill in "Mobile Number" with "07827 123456"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated."
    And I can see my "Mobile Number" is "07827 123456"

  @javascript
  Scenario: User editing another user’s Mobile Number - Administrator
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And their mobile number is "07976 123456"
    When I go to their profile page
    Then I can see their "Mobile Number" field
    When I click on the "Edit" link for "Mobile Number"
    Then an "Edit Mobile Number" dialogue opens
    When I fill in "Mobile Number" with "07827 123456"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated for Alice Smith."
    And I can see their "Mobile Number" is "07827 123456"

  @javascript
  Scenario: User editing own Emergency Contact Name and Number
    Given I am logged in
    And my contact name is "Alice Smith"
    And my contact number is "07976 123456"
    When I go to my profile page
    Then I can see my "Emergency Contact" field
    When I click on the "Edit" link for "Emergency Contact"
    Then an "Edit Emergency Details" dialogue opens
    When I fill in "Contact Name" with "Bob Jones"
    And I fill in "Contact Number" with "07827 123456"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated."
    And I can see my "Emergency Contact" is "Bob Jones 07827 123456"

  @javascript
  Scenario: User editing another user’s Emergency Contact Name and Number - Administrator
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And their contact name is "Carla Brown"
    And their contact number is "07976 123456"
    When I go to their profile page
    Then I can see their "Emergency Contact" field
    When I click on the "Edit" link for "Emergency Contact"
    Then an "Edit Emergency Details" dialogue opens
    When I fill in "Contact Name" with "Bob Jones"
    And I fill in "Contact Number" with "07827 123456"
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated for Alice Smith."
    And I can see my "Emergency Contact" is "Bob Jones 07827 123456"

  @javascript
  Scenario: User editing own Medical Notes
    Given I am logged in
    And my medical notes are "Fish!"
    When I go to my profile page
    Then I can see my "Medical Notes" field
    When I click on the "Edit" link for "Medical Notes"
    Then an "Edit Emergency Details" dialogue opens
    When I fill in "Medical Notes" with "Bees."
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated."
    And I can see my "Medical Notes" are "Bees."

  @javascript
  Scenario: User editing another user’s Medical Notes - Administrator
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And their medical notes are "Fish!"
    When I go to their profile page
    Then I can see their "Medical Notes" field
    When I click on the "Edit" link for "Medical Notes"
    Then an "Edit Emergency Details" dialogue opens
    When I fill in "Medical Notes" with "Bees."
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated for Alice Smith."
    And I can see their "Medical Notes" are "Bees."

  @javascript
  Scenario: User editing own Medical Notes
    Given I am logged in
    And my food notes are "Fish!"
    When I go to my profile page
    Then I can see my "Food Notes" field
    When I click on the "Edit" link for "Medical Notes"
    Then an "Edit Emergency Details" dialogue opens
    When I fill in "Food Notes" with "Bees."
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated."
    And I can see my "Food Notes" are "Bees."

  @javascript
  Scenario: User editing another user’s Food Notes - Administrator
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And their food notes are "Fish!"
    When I go to their profile page
    Then I can see their "Food Notes" field
    When I click on the "Edit" link for "Food Notes"
    Then an "Edit Emergency Details" dialogue opens
    When I fill in "Food Notes" with "Bees."
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated for Alice Smith."
    And I can see their "Food Notes" are "Bees."

  @javascript
  Scenario: User editing own General Notes
    Given I am logged in
    And my general notes are "Fish!"
    When I go to my profile page
    Then I can see my "General Notes" field
    When I click on the "Edit" link for "General Notes"
    Then an "Edit General Notes" dialogue opens
    When I fill in "Notes" with "Bees."
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated."
    And I can see my "General Notes" are "Bees."

  @javascript
  Scenario: User editing another user’s General Notes - Administrator
    Given I am logged in
    And I am an "Administrator" user
    And there is another user
    And their name is "Alice Smith"
    And their general notes are "Fish!"
    When I go to their profile page
    Then I can see their "General Notes" field
    When I click on the "Edit" link for "General Notes"
    Then an "Edit General Notes" dialogue opens
    When I fill in "Notes" with "Bees."
    And I click the "Save" button
    Then a success message is displayed saying "User profile updated for Alice Smith."
    And I can see their "General Notes" are "Bees."
