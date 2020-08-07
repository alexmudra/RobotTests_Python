*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${url}   http://eauction-dev.byustudio.in.ua/login


*** Test Cases ***
LoginTest
    Open Browser    {url}   {browser}
    Click Element   xpath=//input[@id="loginform-username"]
    Input Text  id:Email    ustudiotesti.ng@gmail.com
    Click Element   xpath=//input[@id="loginform-password"]
    Input Text  id:Password     ustudiotesti.ng@gmail.com
    Click Button    xpath=//button[@class="mk-btn mk-btn_accept"]
    Close Browser


*** Keywords ***

