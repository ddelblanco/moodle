@mod @mod_lti
Feature: Rename external tools via inline editing
  In order to keep track of my activities
  As a teacher
  I need to be able to rename the LTI tool and have it's name change in the gradebook

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Terry1    | Teacher1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1 | 0 |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |

  @javascript
  Scenario: Add a tool and inline edit
    When I log in as "teacher1"
    And I follow "Course 1"
    And I turn editing mode on
    And I add a "External tool" to section "1" and I fill the form with:
      | Activity name | Test tool activity 1 |
    And I open "Test tool activity 1" actions menu
    And I choose "Edit settings" in the open action menu
    And I set the field "Tool URL" to local url "/mod/lti/tests/fixtures/ims_cartridge_basic_lti_link.xml"
    And I press "Save and return to course"
    And I click on "Edit title" "link" in the "li#section-1" "css_element"
    And I set the field "New name for activity Test tool activity 1" to "Test tool activity renamed"
    And I press key "13" in the field "New name for activity Test tool activity 1"
    And I navigate to "Setup > Gradebook setup" in the course gradebook
    Then I should not see "Test tool activity 1"
    And I should see "Test tool activity renamed"