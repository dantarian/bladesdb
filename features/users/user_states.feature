Feature: User States
	Unconfirmed users cannot log in
	Suspended users cannot log in
	Pending users can log in with a warning notice
	Web-only users can log in
	Active users can log in
	
	Scenario: Unconfirmed users cannot log in
		Given I am a user who is unconfirmed
		When I log in
		Then I am not logged in
		And a notice message is displayed saying "You have to confirm your account before continuing."
		
	Scenario: Suspended users cannot log in
		Given I am a user who is suspended
		When I log in
		Then I am not logged in
		And a notice message is displayed saying "Your account has been suspended. This may be because you haven't paid your membership fee for this year, nor indicated to the BathLARP committee that you wish to continue your membership. Please e-mail the committee if you wish to do this, or if you believe that your account has been suspended in error."

	Scenario: Pending users can log in with a warning notice
		Given I am a user who is confirmed
		When I log in
		Then a success message is displayed saying "Signed in, but your account is not yet approved. This may be because we haven't figured out who you are in real life - please email the committee."
		
	Scenario: Web-only users can log in
		Given I am a "webonly" user
		When I log in
		Then a success message is displayed saying "Signed in successfully."
		
	Scenario: Active users can log in
		Given I am a user who is approved
		When I log in
		Then a success message is displayed saying "Signed in successfully."