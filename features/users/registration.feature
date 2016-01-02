Feature: Registration
  Users need to be registered and approved to get full access to the website.
  Unregistered users attempting to access restricted pages will be redirected to the login page.
  Newly-registered users must confirm their e-mail address before they can log in.
  Unapproved users will be warned when they log in that their account is limited.
  Approved users do not get a warning when they log in that their account is limited.
  Approved users cannot visit the Registration page.

  Scenario: Attempt to access restricted page without being signed in
    Given a restricted page
    And I go to the home page
    And I am not logged in
    When I go to the page
    Then the home page is displayed
    And an error message is displayed saying "You must be logged in to view that page."

  Scenario: Register account
    Given I go to the home page
    And I am not logged in
    When I go to the registration page
    And I fill in "Real name" with "Test User"
    And I fill in "Username" with "testuser"
    And I fill in "E-mail address" with "testuser@mail.com"
    And I fill in "Password" with "Passw0rd"
    And I fill in "Confirm password" with "Passw0rd"
    And I click the "Sign up" button
    Then the home page is displayed
    And a success message is displayed saying "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    And "testuser@mail.com" should receive an email
    When I open the email
    Then I should see "activate" in the email body

  Scenario: Attempt to sign in without confirming e-mail address
    Given I have registered
    But I have not confirmed my e-mail address
    When I log in
    Then I am not logged in
    And a notice message is displayed saying "You have to confirm your account before continuing."

  Scenario: Confirm e-mail address
    Given I have registered with "testuser@mail.com"
    But I have not confirmed my e-mail address
    When "testuser@mail.com" opens the email
    And I click the first link in the email
    Then the login page is displayed
    And a success message is displayed saying "Your account was successfully confirmed and is awaiting approval for full site access."

  Scenario: Sign in as unapproved user
    Given I have registered
    And I have confirmed my account
    But I have not been approved
    When I log in
    Then a success message is displayed saying "Signed in, but your account is not yet approved. This may be because we haven't figured out who you are in real life - please email the committee."

  Scenario: View users list as unapproved user
    Given I have registered
    But I have not been approved
    And I have logged in
    And there is another user
    When I go to the list users page
    Then the home page is displayed
    And an error message is displayed saying "You do not have permission to perform that action."

  Scenario: Sign in as approved user
    Given I have registered
    And I have confirmed my account
    And I have been approved
    When I log in
    Then a success message is displayed saying "Signed in successfully."

  Scenario: Logged in user cannot visit registration page
    Given I have logged in
    When I go to the registration page
    Then the home page is displayed
    And a notice message is displayed saying "You are already signed in."
    