@javascript
Feature: Sidebar Management
  As an admin or committee member
  I want to manage the contents of the site sidebar
  So that users can find information more easily

  Background:
    Given there is an admin user
    And the user is logged in

  Scenario: Add a category
    When the user adds a sidebar category
    Then the category should appear in the sidebar

  Scenario: Remove a category
    Given there is a sidebar category
    When the user removes the sidebar category
    Then the category should not appear in the sidebar

  Scenario: Reorder categories
    Given there are three sidebar categories
    When the user moves the first category down
    And the user moves the last category up
    Then the second category should be first
    And the third category should be second
    And the fist category should be last

  Scenario: Add a user-defined page to a category
    Given there is a sidebar category
    And there is a page
    When the user adds the page to the sidebar category
    Then the page should appear under the category in the sidebar
    When the user clicks on the page in the sidebar
    Then the page should be displayed

  Scenario: Add a fixed URL page to a category
    Given there is a sidebar category
    When the user adds the home page to the sidebar category
    Then the page should appear under the category in the sidebar
    When the user clicks on the page in the sidebar
    Then the home page should be displayed

  Scenario: Remove a page from the category
    Given there is a sidebar category
    And there is a page in the sidebar category
    When the user removes the page from the sidebar category
    Then the page should not appear under the the category in the sidebar

  Scenario: Reorder pages within a category
    Given there is a sidebar category
    And there are three pages in the sidebar category
    When the user moves the first page down
    And the user moves the third page up
    Then the second page should be first
    And the third page should be second
    And the first page should be last
