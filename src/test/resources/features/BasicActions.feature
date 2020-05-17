Feature: Basic Actions

  Background:
    Given I navigate to "Home" page
    And   I click "Dismiss button"
    And   I click "Me want it"
    And   I click "Snackbar button"

  @WIP
  Scenario: Search for banana
    When I search for "banana"
    And  I click text "Banana Juice (1000ml)"
    Then I see "search results" with following data:
      | Name         | Banana Juice (1000ml)     |
      | Description  | Monkeys love it the most. |
      | Price        | 1.99                      |

  @WIP
  Scenario: Create new Juice Shop user
    When I click "Account button"
    And  I click "Login button"
    And  I click "Not yet a customer"
    And  I set "Email field" to "foo@bar.com"
    And  I set "Password field" to "easyPassword123"
    And  I set "Password repeat field" to "easyPassword123"
    And  I click "Security question"
    And  I click text "Name of your favorite pet?"
    And  I set "Security answer" to "Mushu"
    And  I click "Registration button"
    Then I see text "Registration completed successfully."

  @WIP
  Scenario: Order an item
    When I click "Account button"
    And  I click "Login button"
    Then I "log in" with following data:
      | Email    | demo |
      | Password | demo |
    When I search for "Juice Shop Artwork"
    And  I click "Add to basket"
    And  I click "Shopping cart button"
    Then I see text "Juice Shop Artwork"
    When I click "Checkout button"
    Then I see text "Dummystreet 42, Mocktown, Testilvania, 12345"
    When I click "Tim tester"
    And  I click "Continue"
    Then I see text "Choose a delivery speed"
    When I click "Standard Delivery"
    And  I click "Continue"
    Then I see text "My Payment Options"
    When I click "Tim tester"
    And  I click "Continue"
    Then I see text "Order Summary"
    When I click "Place your order and pay"
    Then I see text "Thank you for your purchase!"

  @WIP
  Scenario Outline: Change language
    When I click "Account button"
    And  I click "Login button"
    Then I "log in" with following data:
      | Email    | demo |
      | Password | demo |
    When I click "Choose language button"
    And  I click text "<Language>"
    And  I click "Snackbar button"
    And  I click "Account button"
    Then I see "Account menu" with following data:
      | Orders & Payment   | <Example 1> |
      | Privacy & Security | <Example 2> |
      | Logout             | <Example 3> |

  Examples:
    | Language | Example 1              | Example 2                | Example 3   | 
    | Deutsch  | Bestellungen & Zahlung | Datenschutz & Sicherheit | Abmelden    |
    |  Česky   | Objednávky & Platby    | Soukromí & Bezpečnost    | Odhlásit se |

  @HOME_WORK @IMPLEMENT_THIS
  Scenario: Change password
    When I click "Account button"
    And  I click "Login button"
    Then I "log in" with following data:
      | Email    | demo |
      | Password | demo |
    When I click "Account button"
    And  I click "Privacy & Security button"
    And  I click "Change password"
    And  I set "Current Password field" to "demo"
    And  I set "New Password field" to "easyPassword123"
    And  I set "Repeat New Password field" to "easyPassword123"
    And  I click "Change"
    Then I see text "Your password was successfully changed."
    When I click "Account button"
    And  I click "Logout"
    And  I click "Account button"
    And  I click "Login button"
    Then I "log in" with following data:
      | Email    | demo            |
      | Password | easyPassword123 |

  @HOME_WORK @IMPLEMENT_THIS
  Scenario: Add new address
    When I click "Account button"
    And  I click "Login button"
    Then I "log in" with following data:
      | Email    | demo |
      | Password | demo |
    When I click "Add to basket"
    And  I click "Shopping cart button"
    And  I click "Checkout button"
    And  I click "Add new address"
    And  I set "Country" to "Latvia"
    And  I set "Name" to "Freeman"
    # The mobile number was too long for the input field, so I removed the country code, instead of removing one digit (so it's still the length of a real mobile number)
    And  I set "Mobile Number" to "20202020"
    And  I set "ZIP code" to "LV-3201"
    And  I set "Address" to "Random Address 25-395"
    And  I set "City" to "Ventspils"
    And  I set "State" to "RandomState"
    And  I click "Submit"
    Then I see "address" with following data:
      | Name    | Freeman               |
      | Address | Random Address 25-395 |
      | Country | Latvia                |
