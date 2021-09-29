<?php

use Behat\Mink\Exception\ElementNotFoundException;
use Behat\Mink\Exception\ExpectationException;
use Drupal\DrupalExtension\Context\MinkContext;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends MinkContext
{
  /**
   * @When I click on :name button with class :class
   * @param $name
   * @param $class
   */
  public function iClickOnButtonWithClass($name, $class)
  {
    $page = $this->getSession()->getPage();
    $button_selector = 'button.' . $class;
    $page->find('css', $button_selector)->click();
  }

  /**
   * @When /^I fill in the "([^"]*)" WYSIWYG editor with "([^"]*)"$/
   * @param $locator
   * @param $text
   */
  public function iFillInTheWysiwygEditor($locator, $text)
  {
    $field = $this->getSession()->getPage()->findField($locator);
    $id = $field->getAttribute('id');
    $this->getSession()
      ->executeScript("CKEDITOR.instances[\"$id\"].setData(\"$text\");");
  }

  /**
   * @Then I should see :arg1 or more elements with class :arg2
   * @param $arg1
   * @param $arg2
   * @throws Exception
   */
  public function iShouldSeeOrMoreElementsWithClass($arg1, $arg2)
  {
    $page = $this->getSession()->getPage();
    $elements_selector = 'div.' . $arg2;
    $elements = $page->findAll('css', $elements_selector);
    if (count($elements) < (int)$arg1) {
      throw new Exception("There are " . count($elements) . " elements with " . $arg2 . " class.");
    }
  }

  /**
   * @Given I press the link to :arg1 node
   * @param $arg1
   */
  public function iPressTheLinkToProduct($arg1)
  {
    $locator = '//a[text()="' . $arg1 . '"]';
    $this->getSession()->getPage()->find('xpath', $locator)->click();
  }
}
