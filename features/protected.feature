@javascript
Feature: Protected
  In order to see protected content
  As a visitor
  I should accept cookies
  Scenario: A visitor should see a list of products on homepage
    Given I am at "/homepage"
    Then I should see the text "Products List"
    When I click "Amet Luctus Mos Tincidunt Vero"
    Then I should see the text "Decet facilisi oppeto os quae quibus refero. Acsi commodo distineo jus lobortis nunc secundum. Jus suscipere typicus veniam. Adipiscing comis duis ea exputo in quadrum refero suscipit vicis."

  Scenario: A visitor can see protected content after accepting cookies
    Given I am at "/node/5"
    And I should see the text "You have not yet given permission to place the required cookies. Accept the required cookies to view this content."
    When I click on "Accept" button with class "important"
    And I am at "/node/5"
    Then I should see the text "Caecus dolore importunus lenis probo te vindico."


