#https://www.youtube.com/watch?v=DCgrW-i9cT8&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=24
*** Settings ***
Library     SeleniumLibrary
Variables   ../robotTests_test.tender-online.com.ua/Resources/locators.py
Resource    ../TestData/ConfigData.robot
Resource    ../Resources/common.robot
Resource    ../Resources/locators_variables_test_to.robot

*** Keywords ***
Open Browser Chrome
    [Arguments]   ${register_page}   ${BROWSER_headless}
    Open Browser    ${register_page}   ${BROWSER_headless}
    Maximize Browser Window
    #Log Screenshot
    ${url}=   get location
    log to console  ${url}
    Should Be True    '${url}' in '${register_page}'   ${msg_identical}
    log to console  ${msg}


*** Test Cases ***

ТС1 Відкрити браузер і зрівняти урли
    Open Browser Chrome     ${register_page}    ${BROWSER_headless}

[Documentation] Зайти на сторінку реєстрації
    #open browser  ${register_page}  ${BROWSER_headless}
    Start TestCase  ${MAIN_URL}  ${BROWSER_headless}
    ${location}=    get location  #запише урл актуального браузера
    log to console  ${location}



[Documentation] перевірка сторінки реєстрації
    Перевірка сторінки після переходу  ${register_page}  ${msg}