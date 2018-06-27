Feature: Does filter and search work correctly?
  Everybody wants to know what filters were searched

  Scenario: User wants to filter when searching
    Given zip is "92626"
      And minimum_price is "$1M"
      And minimum_price_numerical is "1000000"
      And minimum_beds is "3"
      And maximum_beds is "5"
      And minimum_sqft is "1,500"

    When the user clicks the search button
    Then I should be able to filter and get results

    When the user chooses a price filter
      And the user chooses a bedroom filter
      And the user chooses a sqft filter
      And the user clicks the Apply Filters button
    Then the results should have the proper price  
      And the results should have the proper number of bedrooms
      And the results should have the proper sqft