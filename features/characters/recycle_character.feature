@javascript
Feature: Recycle character
  As a player
  I want to recycle a character for monster points
  If I've played them a couple of games and not enjoyed the character

  Background:
    Given there is a user
    And the user has no joining bonus monster point adjustment
    And the user has a character
    And the user is logged in

  Scenario Outline: Character can be recycled
    Given the character has played <games> games, earning 10 character points per game
    And the character has <points> character points before the games
    When the user recycles the character
    Then the character should be recycled
    And the user should have a pending monster point adjustment for <mp_refund> monster points

    Examples:
      | games | points | mp_refund |
      | 0     | 21     | 1         |
      | 1     | 40     | 30        |
      | 2     | 100    | 100       |
      | 3     | 170    | 180       |

  Scenario Outline: Character can be recycled with monster point spends
    Given the character has <start_cp> character points
    And the character has bought <cp_bought> character points for <mp_spent> monster points
    When the user recycles the character
    Then the user should have a pending monster point adjustment for <mp_refund> monster points

    Examples:
      | start_cp | cp_bought | mp_spent | mp_refund |
      | 20       | 10        | 10       | 10        |
      | 100      | 10        | 20       | 100       |

  Scenario: Character can be recycled with multiple monster point spends
    Given the character has 80 character points
    And the character has bought 20 character points for 20 monster points
    And the character has bought 10 character points for 20 monster points
    When the user recycles the character
    Then the user should have a pending monster point adjustment for 100 monster points

  Scenario: Character cannot be recycled if they've played 4 or more games
    Given the character has played 4 games
    When the user tries to recycle the character
    Then the user should be unable to recycle the character
