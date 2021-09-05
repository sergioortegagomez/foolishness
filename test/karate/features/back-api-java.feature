Feature: Book Tests - Back-API-Node

  Background:
    * def urlBase = 'http://back-api-java'

  Scenario: Get Status OK
    Given url urlBase
    When method GET
    Then status 200
  
  Scenario: Book Initial Count
    Given url urlBase + '/book/count'
    When method GET
    Then status 200
    * def initialCount = 0
		* def evaluate = get[0] response.total 
		* match initialCount == get[0] response.total

  Scenario: Create Book
    Given url urlBase + '/book/create'
    And def book = 
		"""
		{
			"title": 'My Book',
      "isbn": "1234567890",
      "pages": "100",
      "author": "Pepito Flores"
		}
		"""
		And request book
    When method POST
    Then status 200
    * def insertedCount = 1
		* def evaluate = get[0] response.insertedCount 
		* match insertedCount == get[0] response.insertedCount

  Scenario: Book Count
    Given url urlBase + '/book/count'
    When method GET
    Then status 200
    * def initialCount = 1
		* def evaluate = get[0] response.total 
		* match initialCount == get[0] response.total

  Scenario: Book Count
    Given url urlBase + '/book/list'
    When method GET
    Then status 200

  Scenario: Remove Book Collection
    Given url urlBase + '/book/drop'
    When method DELETE
    Then status 200
