Feature: foolishness

	Scenario: foolishness main web
		Given I navigate to "http://web"        
        
    Scenario: foolishness create
		Given I navigate to "http://web"
        Then I click on element having id "buttonCreate"
        
    Scenario: foolishness list
		Given I navigate to "http://web"
        Then I click on element having id "buttonList"
        
    Scenario: foolishness remove
		Given I navigate to "http://web"
        Then I click on element having id "buttonRemove"        