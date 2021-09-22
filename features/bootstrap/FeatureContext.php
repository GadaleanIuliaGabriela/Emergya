<?php

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

}
