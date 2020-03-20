Feature: foolishness

	Scenario: foolishness main web
		Given I navigate to "http://web"
    Then element having id "yesCount" should have text as "0"
    Then element having id "noCount" should have text as "0"
    Then element having id "maybeCount" should have text as "0"
    Then element having id "total" should have text as "0"
        
  Scenario: foolishness vote Yes
		Given I navigate to "http://web"
    And I click on element having id "buttonYes"
    Then element having id "yesCount" should have text as "1"
    And element having id "total" should have text as "1"
        
  Scenario: foolishness vote No
		Given I navigate to "http://web"
    And I click on element having id "buttonNo"    
    Then element having id "noCount" should have text as "1"
    And element having id "total" should have text as "2"
        
  Scenario: foolishness vote Maybe
		Given I navigate to "http://web"
    And I click on element having id "buttonMaybe"    
    Then element having id "maybeCount" should have text as "1"
    And element having id "total" should have text as "3"

  Scenario: foolishness remove votes
		Given I navigate to "http://web"
    And I click on element having id "buttonRemove"
    Then element having id "yesCount" should have text as "0"
    Then element having id "noCount" should have text as "0"
    Then element having id "maybeCount" should have text as "0"
    Then element having id "total" should have text as "0"