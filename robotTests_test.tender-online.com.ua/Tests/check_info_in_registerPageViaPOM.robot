#https://www.youtube.com/watch?v=DCgrW-i9cT8&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=24
*** Settings ***
Library     SeleniumLibrary
Variables   ../robotTests_test.tender-online.com.ua/Resources/locators.py


*** Variables ***
${doc_index}                                             0
${BROWSER_chrome}                                        Chrome
${BROWSER_headless}                                      headlesschrome

${MAIN_URL}                                              https://test.tender-online.com.ua
${register_page}                                         https://test.tender-online.com.ua/register
${searh_tender_url}                                      https://test.tender-online.com.ua/tenders/index
${search_catalogues_page}                                https://test.tender-online.com.ua/catalogue/groups
${searh_actual_tender_url}                               https://test.tender-online.com.ua/tenders/actual

${msg_link_is}                                           Лінк має наступний вигляд:
${msg_identical}                                         Сторінки ідентичні
${msg_not_identical}                                     Сторінки не ідентичні

#LOCATORS

${lctr_select_status_value="active.tendering"}            xpath=//*[@id="status"]/option[2]
${lctr_select_status_active.enquiries}                    xpath=//*[@id="status"]/option[3]
${lctr_is_zamovnik}                                       xpath=//*[@id="companies-is_seller"]
${lctr_is_uchasnick}                                      xpath=//*[@id="companies-is_seller"]/option[2]
${lctr_select_zamovORuchasnick}                           xpath=//*[@id="registration-form"]/div[1]/div[1]/label

*** Keywords ***
Open Browser Chrome
    [Arguments]   ${BROWSER_headless}   ${register_page}
    Open Browser    ${BROWSER_headless}  ${register_page}
    Maximize Browser Window
    Capture Page Screenshot

Compare url and links
    [Arguments]  ${msg_identical}
    ${url}=     get location
    should be true  '${url}' in '${register_page}'
    #log to console  ${msg_identical}
    Capture Page Screenshot



*** Test Cases ***
Open register page in headless chome
    Open Browser Chrome   ${register_page}  ${BROWSER_headless}

Compare urls
    Compare url and links   ${msg_identical}

