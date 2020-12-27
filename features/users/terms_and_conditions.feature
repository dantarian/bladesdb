Feature: Terms and Conditions
  As the site administrator
  I want users to agree to the site terms and conditions
  So that I can protect myself from vexatious users

  Scenario: No T&C acceptance screen with no T&C statements
    Given there is a user
    And the user is logged in
    When the user visits the home page
    Then the home page should be displayed

#   Scenario: T&C acceptance screen shown for users who haven't accepted any T&Cs
#     Given there is a user
#     And there is a Terms and Conditions statement
#     When the user logs in
#     Then the user should see the Terms and Conditions Acceptance screen
#
#   Scenario: Acceptance of T&Cs for legacy users
#     Given there is a user
#     And there is a Terms and Conditions statement
#     And the user is logged in
#     When the user visits the home page
#     And the user accepts the Terms and Conditions
#     Then the home page should be displayed
#
#   Scenario: Rejection of T&Cs for legacy users
#     Given there is a user
#     And there is a Terms and Conditions statement
#     And the user is logged in
#     When the user visits the home page
#     And the user rejects the Terms and Conditions
#     And the user accepts that their account will be suspended
#     Then the user should be logged out
#     And the user's account should be suspended
#
#   Scenario: T&C acceptance screen shown for users who haven't accepted the most recent T&Cs
#     Given there is a Terms and Conditions statement
#     And there is a user
#     And there is a new Terms and Conditions statement
#     When the user logs in
#     Then the user should see the Terms and Conditions Acceptance screen
#
#   Scenario: Acceptance of changed T&Cs
#     Given there is a Terms and Conditions statement
#     And there is a user
#     And there is a new Terms and Conditions statement
#     And the user is logged in
#     When the user visits the home page
#     And the user accepts the Terms and Conditions
#     Then the home page should be displayed
#
#   Scenario: Rejection of changed T&Cs
#     Given there is a Terms and Conditions statement
#     And there is a user
#     And there is a new Terms and Conditions statement
#     And the user is logged in
#     When the user visits the home page
#     And the user rejects the Terms and Conditions
#     And the user accepts that their account will be suspended
#     Then the user should be logged out
#     And the user's account should be suspended
