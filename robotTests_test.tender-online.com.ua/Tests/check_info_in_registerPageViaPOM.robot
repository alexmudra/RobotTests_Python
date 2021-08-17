#https://www.youtube.com/watch?v=DCgrW-i9cT8&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=24

*** Settings ***
Library     SeleniumLibrary
Variables   ../Resources/locators.py

Resource   ..RobotTests_Python/robotTests_test.tender-online.com.ua/Resources/locators.py
Resource   ../robotTests_test.tender-online.com.ua/Resources/locators.py

*** Variables ***
${MAIN_URL}=   https://test.tender-online.com.ua
${register_page}=   https://test.tender-online.com.ua/register
${searh_tender_url}=  " https://test.tender-online.com.ua/tenders/index"
${search_catalogues_page}=     "https://test.tender-online.com.ua/catalogue/groups"
${searh_actual_tender_url}=    "https://test.tender-online.com.ua/tenders/actual"

${BROWSER_headless} =   headlesschrome


${lctr_select_status_value_active_tendering}=      "xpath=//*[@id="status"]/option[2]"
${lctr_select_status_active_enquiries}=        "xpath=//*[@id="status"]/option[3]"
${lctr_is_zamovnik}=       "xpath=//*[@id="companies-is_seller"]"
${lctr_is_uchasnick}=      "xpath=//*[@id="companies-is_seller"]/option[2]"
${lctr_select_zamovORuchasnick}=  "xpath=//*[@id="registration-form"]/div[1]/div[1]/label"

*** Keywords ***
Open Browser Chrome
    [Arguments]   ${BROWSER_headless}   ${register_page}
    Open Browser    ${BROWSER_headless}  ${register_page}
    Maximize Browser Window
    Capture Page Screenshot

#    ${url}=     get location
#    Should Be True    '${url}' in '${register_page}'    msg=${msg}
#    log to console  ${msg}


*** Test Cases ***
Open chome browser
    Open Browser Chrome   ${register_page}  ${BROWSER_headless}


