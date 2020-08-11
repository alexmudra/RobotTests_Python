##пишу тест для http://www.practiceselenium.com/practice-form.html
#лінк на те як працювати із http://rtomac.github.io/robotframework-selenium2library/doc/Selenium2Library.html#Select%20Radio%20Button

*** Settings ***
Library  SeleniumLibrary
Library  String
Library  DateTime

*** Variables ***
${browser}  chrome
${url}  http://www.practiceselenium.com/practice-form.html
${male_sex}  xpath://input[@id='sex-0']


*** Test Cases ***
Testing Radiobuttons and Check-boxes
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Set Selenium Speed  1seconds  #Sets the delay that is waited after each Selenium command.

    Select Radio Button  sex  Female      #Sets selection of radio button group identified by group_name to value.
    Select Radio Button  exp  7

    #Selecting check-boxes
    Select Checkbox  RedTea
    Select Checkbox  oolongtea

    #Unselecting radiobutton
    Unselect Checkbox  Black Tea  #Removes selection of checkbox identified by locator.


    Close Browser


*** Keywords ***