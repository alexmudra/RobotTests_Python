#link lesson https://www.youtube.com/watch?v=nRF53mUIceQ&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=5

*** Settings ***
Library  SeleniumLibrary
Library  String
Library  DateTime

*** Variables ***
${browser}  chrome
${url}  http://www.practiceselenium.com/practice-form.html


*** Test Cases ***
HandlingDropDowndsAndLists
    Open Browser    ${url}  ${browser}
    Set Selenium Speed  1seconds
    Select From List By Label   continents  Australia   #Selects options from selection list locator by labels.
    #вцілому все що ми бачим в селекті і є лейбл н-д: Australia
    Select From List By Index   continents  5   #Selects options from selection list locator by indexes(індекс ставимо
    #вручну починаючи із 0 навіть якщо цих індексів немає в селекті)

    #Select From List By Value

    #вибрати багато значень із list-box
    Select From List By Label   selenium_commands   Switch Commands
    Select From List By Label   selenium_commands   WebElement Commands
    Select From List By Label   selenium_commands   Navigation Commands
    Select From List By Index   selenium_commands   0

    Unselect From List By Label   selenium_commands   WebElement Commands   #Unselects options from selection list locator by labels.

    Close Browser


*** Keywords ***