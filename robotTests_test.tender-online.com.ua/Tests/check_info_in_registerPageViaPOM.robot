#https://www.youtube.com/watch?v=DCgrW-i9cT8&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=24
*** Settings ***
Library     SeleniumLibrary
Variables   ../robotTests_test.tender-online.com.ua/Resources/locators.py

*** Keywords ***
Open Browser Chrome
    [Arguments]   register_page   ${BROWSER_headless}
    Open Browser    ${register_page}   ${BROWSER_headless}
    Maximize Browser Window

    ${url}=     get location
    Should Be True    '${url}' in '${register_page}'    msg=${msg}
    log to console  ${msg}


*** Test Cases ***

