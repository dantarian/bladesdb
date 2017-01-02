Feature: Title Display
	As a player
	I want the correct title for my character to be displayed
	So they are referred to correctly in-game.
	
	Scenario Outline: Titles in a Guild with no branches
		Given there is a Guild
		And the Guild has rank-based titles
		And there is a user
		And the user has a character
		And the character is a member of the Guild
		And the character joined the Guild at rank <start>
		When the character is at rank <current>
		Then the character's title should be <title>
		
		Examples:
			| start | current | title       |
			| 0     | 2       | Wizard      |
			| 0     | 9.9	  | Wizard      |
			| 0     | 10      | High Wizard |
			| 0     | 50      | Arch Wizard |
			| 10    | 10      | Wizard      |
			| 10    | 20      | High Wizard |
			
	Scenario Outline: Titles in a Guild with branches
		Given there is a Guild
		And the Guild has branches
		And the Guild has rank-based branch titles
		And there is a user
		And the user has a character
		And the character is a member of the last branch of the Guild
		And the character joined the Guild at rank <start>
		When the character is at rank <current>
		Then the character's title should be <title>
		
		Examples:
			| start | current | title           |
			| 0     | 2       | Pyromancer      |
			| 0     | 9.9     | Pyromancer      |
			| 0     | 10      | High Pyromancer |
			| 0     | 50      | Arch Pyromancer |
			| 10    | 10      | Pyromancer      |
			| 10    | 20      | High Pyromancer |
		
	Scenario Outline: Titles in a Guild with static titles
		Given there is a Guild
		And the Guild has a static title
		And there is a user
		And the user has a character
		And the character is a member of the Guild
		And the character joined the Guild at rank <start>
		When the character is at rank <current>
		Then the character's title should be <title>
		
		Examples:
			| start | current | title    |
			| 0     | 2       | Humact   |
			| 0     | 20      | Humact   |
			| 10    | 10      | Humact   |
			| 10    | 20      | Humact   |
			
	Scenario Outline: Titles in a Guild with branches with static titles
		Given there is a Guild
		And the Guild has branches
		And the Guild has static branch titles
		And there is a user
		And the user has a character
		And the character is a member of the last branch of the Guild
		And the character joined the Guild at rank <start>
		When the character is at rank <current>
		Then the character's title should be <title>
		
		Examples:
			| start | current | title      |
			| 0     | 2       | Pyromancer |
			| 0     | 10      | Pyromancer |
			| 10    | 10      | Pyromancer |
			| 10    | 20      | Pyromancer |
		
	Scenario Outline: Custom titles don't change with rank
		Given there is a Guild
		And the Guild has rank-based titles
		And there is a user
		And the user has a character
		And the character has a custom title
		And the character is a member of the Guild
		And the character joined the Guild at rank <start>
		When the character is at rank <current>
		Then the character's title should be <title>
		
		Examples:
			| start | current | title    |
			| 0     | 2       | Kickasso |
			| 0     | 9.9     | Kickasso |
			| 0     | 10      | Kickasso |
			| 0     | 100     | Kickasso |
			| 10    | 2       | Kickasso |
		
	Scenario Outline: No title doesn't change with rank
	
		Given there is a Guild
		And the Guild has rank-based titles
		And there is a user
		And the user has a character
		And the character has no title
		And the character is a member of the Guild
		And the character joined the Guild at rank <start>
		When the character is at rank <current>
		Then the character should have no title
		
		Examples:
			| start | current |
			| 0     | 2       |
			| 0     | 20      |
			| 0     | 200     |
			| 10    | 10      |
			| 10    | 20      |