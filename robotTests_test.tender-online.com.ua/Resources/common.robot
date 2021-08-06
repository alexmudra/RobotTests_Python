*** Settings ***
Library     SeleniumLibrary
Resource    ../TestData/ConfigData.robot

*** Keywords ***
Start TestCase
    Open Browser    ${register_page}  ${BROWSER_chrome}
    Maximize Browser Window
    ${curr_url}=    get location
    log to console      ${msg_link_is}  ${curr_url}
    log many    ${msg_link_is}  ${curr_url}

Finish TestCase
    Close Browser

Check site url
    Open Browser    ${register_page}  ${BROWSER_chrome}
    Maximize Browser Window
    ${curr_url}=    get location
    log to console  ${curr_url}
    log many    ${curr_url}
    [Return]   ${curr_url}

Close my browsers
    close all browsers