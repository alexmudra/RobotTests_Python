*** Settings ***
Library  SeleniumLibrary
Library  String
Library  DateTime

*** Variables ***
${browser}  chrome
${url}  http://eauction-dev.byustudio.in.ua/login


*** Test Cases ***
LoginTest
    Open Browser    ${url}  ${browser}
    loginToApplication
    Close Browser


*** Keywords ***
#створив кейворд для того щоб використати його в розділі тест-кейсес
loginToApplication
    Click Element   xpath=//input[@id="loginform-username"]
    Input Text  id:loginform-username  ustudiotesti.ng@gmail.com
    Click Element   xpath=//input[@id="loginform-password"]
    Input Text  id:loginform-password  ustudiotesti.ng@gmail.com
    Click Button    xpath=//button[@class="mk-btn mk-btn_accept"]

