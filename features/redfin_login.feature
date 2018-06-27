Feature: Does login work correctly?
  Everybody wants to know when it's logged in

  Scenario: User wants to log in
    Given email is "severussnape98765@gmail.com"
      And password is "Acorns123."
      And firstName is "Severus"

    When the user clicks the login button
    Then I should be logged in