*** Settings ***
Library  SeleniumLibrary
Library  String
Library  DateTime

*** Variables ***
${browser}  chrome
${url}  http://eauction-dev.byustudio.in.ua/tenders/index
${page_title}   Аукціони


*** Test Cases ***
TestingInputBox
    Open Browser    ${url}  ${browser}
    Maximize Browser Window
    Title Should Be     ${page_title}
    Click Link  xpath=//li[@class='item-login']//a[contains(text(),'i')]
    ${"email_txt"}  Set Variable    id:loginform-username       ##обявляємо і записуємо в перемінну інфо із емайлу

    Element Should Be Visible   ${"email_txt"}    ##перевіряємо чи елемент доступний до перегляду
    Element Should Be Enabled   ${"email_txt"}    ##перевіряємо чи елемент Verifies that element identified with locator is enabled.

    Input Text  ${"email_txt"}  ustudiotesti.ng@gmail.com       #вставимо емайл в поле
    Sleep   5           #система засне на 5 секунд
    Clear Element Text  ${"email_txt"}          #очистимо дані в полі із вже введеними даними по ${"email_txt"}
    Sleep   3
    Close Browser


*** Keywords ***