@javascript @api
Feature: Protected
  In order to see protected content
  As a visitor
  I should accept cookies

  Scenario: Check if product nodes are visible on homepage
    Given I am on "/homepage"
    Then I should see "10" or more elements with class "product-list-item"

  Scenario: Check if add product page is accessible for unauthenticated users
    Given I am on "/node/add/product"
    Then I see the text "You are not authorized to access this page."

  Scenario: Log in with admin user and create a new protected product node and check its visibility
    Given I am logged in as a user with the "Administrator" role
    Given I am on "/user/login"
    And I fill in the following:
      | edit-name   | admin   |
      | edit-pass   | admin   |
    And I press the "Log in" button
    Then I should see the text "Member for"
    Given I am on "/node/add/product"
    Then I should see the text "Create Product"
    Given I fill in the following:
      | edit-title-0-value                  | TestProduct   |
      | edit-field-qty-0-value              | 100           |
      | edit-field-price-0-value            | 100           |
    And I fill in the "edit-body-0-value" WYSIWYG editor with "Test Product Body"
    And I check the box "edit-field-protected-value"
    And I attach the file "test.jpg" to "edit-field-image-product-0-upload"
    And I wait for AJAX to finish
    And I fill in the following:
        | field_image_product[0][alt]       | test          |
    And I press the "Save" button
    And I am on "/homepage"
    Then I should see the text "TestProduct"
    And I press the link to "TestProduct" node
    And I should not see the text "Test Product Body"
    And I should see the text "You have not yet given permission to place the required cookies. Accept the required cookies to view this content."
    And I click on "Accept" button with class "important"
    Given I am on "/homepage"
    And I press the link to "TestProduct" node
    Then I should see the text "Test Product Body"

