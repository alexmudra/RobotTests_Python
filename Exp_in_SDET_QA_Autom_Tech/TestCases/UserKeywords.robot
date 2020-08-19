
# lesson 13 https://www.youtube.com/watch?v=Ar-iQnvahxQ&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=13


*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${login}    test@test17.com
${psw}  test@test17.com
${url}  http://practice.automationtesting.in/my-account/


*** Test Cases ***
UserKeywordTC
    open browser    ${url}  ${browser}
    Maximize Browser Window
    input text  xpath://input[@id='username']  ${login}
    input password  xpath://input[@id='password']   ${psw}




