Feature: Money Display
  Money shall be displayed as whole numbers of groats and florins in the format "[x]g [y]f", where [x] is the number of groats and [y] is the number of florins.
  The number of groats displayed shall be the total number of florins divided by ten, rounding towards zero.
  The number of florins displayed shall be the total number of florins modulo ten.
  If the number of florins to be displayed is zero, then the number of florins may be omitted.
  If the number of groats to be displayed is zero, but the number of florins to be displayed is non-zero, then the number of groats may be omitted.
  Negative amounts of money will be displayed with a leading "-".
  
  Scenario Outline: Money display.
    Given there is <total> money to display
    Then the money is displayed as <display>
    
    Examples:
      | total | display |
      | 0     | 0g      |
      | 1     | 1f      |
      | 10    | 1g      |
      | 11    | 1g 1f   |
      | -1    | -1f     |
      | -10   | -1g     |
      | -11   | -1g 1f  |
      