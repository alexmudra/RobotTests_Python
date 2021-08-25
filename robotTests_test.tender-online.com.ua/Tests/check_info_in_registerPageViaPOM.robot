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
${lctr_is_zamovnik}                                       xpath=//*[@id="companies-is_seller"]/option[1]
${lctr_is_uchasnick}                                      xpath=//*[@id="companies-is_seller"]/option[2]
${lctr_select_zamovORuchasnick}                           xpath=//*[@id="registration-form"]/div[1]/div[1]/label
${lctr_is_seller}                                         xpath=//*[@id="companies-is_seller"]

*** Keywords ***
Open Browser Chrome
    [Arguments]   ${BROWSER_headless}   ${register_page}
    Open Browser    ${BROWSER_headless}  ${register_page}
    Maximize Browser Window
    #Capture Page Screenshot

Compare url and links
    [Arguments]  ${msg_identical}
    ${url}=     get location
    should be true  '${url}' in '${register_page}'
    #log to console  ${msg_identical}
    #Capture Page Screenshot

#https://github.com/vargatuk/portal/blob/master/Resource/page_object/main.robot
Compare zamovnik or not
    [Arguments]  ${lctr_is_zamovnik}
    Wait until element is visible   ${lctr_is_zamovnik}     timeout=20
    ${is_zamovnik}=  get variable value  ${lctr_is_zamovnik}
    should be true  '${is_zamovnik}' in '${lctr_is_zamovnik}'   msg='значення співпадають'
    #Capture Page Screenshot

#Get list items on Register Page
#    [Arguments] ${register_page}
#    ${companies_values}=  Get


List selection should be or how to handle select options in test TO
    [Arguments]     ${lctr_is_seller}   ${lctr_is_zamovnik}
    Maximize Browser Window
    #Scroll Element into view    ${lctr_is_seller}

    Page Should Contain List    xpath=//*[@id="companies-is_seller"]

    Page Should Not Contain List    xpath=//*[@id="companies-is_seller_99"]

    @{all_items_in_select}=  Get List Items  xpath=//*[@id="companies-is_seller"]

    ${get_list_label}=  Get Selected List Label  xpath=//*[@id="companies-is_seller"]

    ${get_selected_value}=  Get selected list values  xpath=//*[@id="companies-is_seller"]

    List selection should be  xpath=//*[@id="companies-is_seller"]  Замовник

    Select From List By Index  xpath=//*[@id="companies-is_seller"]  0
    ${get_label_from_select_by_Index}=  Get Selected List Label  xpath=//*[@id="companies-is_seller"]
    log to console  ${get_label_from_select_by_Index}
    sleep  2s

    Select From List By Label  xpath=//*[@id="companies-is_seller"]  Замовник
    ${get_label_from_select_by_Label}=  Get Selected List Label  xpath=//*[@id="companies-is_seller"]
    sleep  2s

    Select From List By Value  xpath=//*[@id="companies-is_seller"]  0
    ${get_label_from_select_by_Label2}=  Get Selected List Label  xpath=//*[@id="companies-is_seller"]
    sleep  2s


*** Test Cases ***
TC1 Open register page in headless chome
    Open Browser Chrome   ${register_page}  ${BROWSER_headless}

TC2 Compare current and register urls
    Compare url and links   ${msg_identical}

TC3 Compare value in zamovnik select
    Compare zamovnik or not  ${lctr_is_zamovnik}

TC4 Defoult value of seller select
    List selection should be or how to handle select options in test TO  Замовник  ${lctr_is_zamovnik}


