#https://www.youtube.com/watch?v=UbYxkUq0Hec&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=1


#https://github.com/vargatuk/portal/blob/master/Resource/page_object/main.robot
#https://github.com/vargatuk/portal/tree/master/Resource/tests
#https://github.com/alexmudra/portal/blob/master/Resource/page_object/common.robot
#https://github.com/vargatuk/portal/blob/master/Resource/page_object/heder_menu/news_page.robot



*** Settings ***
Library  Selenium2Library
Library  String
Library  DateTime


*** Variables ***
${doc_index}                                             0
${BROWSER_chrome}                                        Chrome
${BROWSER_headless}                                      headlesschrome

${MAIN_URL}                                              https://test.tender-online.com.ua
${register_page}                                         https://test.tender-online.com.ua/register
${searh_tender_url}                                      https://test.tender-online.com.ua/tenders/index
${search_catalogues_page}                                https://test.tender-online.com.ua/catalogue/groups
${searh_actual_tender_url}                               https://test.tender-online.com.ua/tenders/actual
${select_status_value="active.tendering"}                xpath=//*[@id="status"]/option[2]
${select_status_active.enquiries}                        xpath=//*[@id="status"]/option[3]
${msg}  Сторінки ідентичні


*** Keywords ***
#from selenium import webdriver
#driver = webdriver.Chrome(executable_path='/home/alex/PycharmProjects/WebDrivers_for_Tests/chromedriver')

Start TestCase
    [Arguments]   ${MAIN_URL}   ${BROWSER_headless}
    Maximize Browser Window


Finish TestCase
    [Arguments]     ${BROWSER}
    close all browsers

*** Test Cases ***

[Documentation] Зайти на сторінку реєстрації
    #open browser  ${register_page}  ${BROWSER_headless}
    Start TestCase  ${MAIN_URL}  ${BROWSER_headless}
    ${location}=    get location  #запише урл актуального браузера
    log to console  ${location}



[Documentation] перевірка сторінки реєстрації
    Перевірка сторінки після переходу  ${register_page}  ${msg}



*** Keywords ***
Перевірка сторінки після переходу
    [Arguments]   ${register_page}  ${msg}
    ${url}=     get location
    Should Be True    '${url}' in '${register_page}'    msg=${msg}
    log to console  ${msg}




#Підготувати дані для оголошення тендера
#  [Arguments]  ${username}  ${tender_data}  ${role_name}
#  ${tender_data}=   adapt_data_for_role   ${role_name}   ${tender_data}
#  Log Many   ${tender_data}
#  [return]  ${tender_data}
#
#Підготувати клієнт для користувача
#  [Arguments]  ${username}
#  Set Global Variable   ${DZO_MODIFICATION_DATE}   ${EMPTY}
#  Set Suite Variable  ${my_alias}  ${username + 'CUSTOM'}
#  Run Keyword If   "${USERS.users['${username}'].browser}" == "Firefox"   Створити драйвер для Firefox   ${username}
#  ...   ELSE   Open Browser   ${USERS.users['${username}'].homepage}   ${USERS.users['${username}'].browser}   alias=${my_alias}
#  Set Window Size   @{USERS.users['${username}'].size}
#  Set Window Position   @{USERS.users['${username}'].position}
#  Run Keyword If   'Viewer' not in '${username}'   Login   ${username}
#
#Створити драйвер для Firefox
#  [Arguments]  ${username}
#  ${download_path}=   get_download_file_path
#  ${folderList_param}=   Convert To Integer   2
#  ${profile}=   Evaluate   sys.modules['selenium.webdriver'].FirefoxProfile()   sys
#  Call Method   ${profile}   set_preference   browser.download.dir   ${OUTPUT_DIR}
#  Call Method   ${profile}   set_preference   browser.download.folderList   ${folderList_param}
#  Call Method   ${profile}   set_preference   browser.download.manager.showWhenStarting   ${False}
#  Call Method   ${profile}   set_preference   browser.download.manager.useWindow   false
#  Call Method   ${profile}   set_preference   browser.helperApps.neverAsk.openFile   application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/pdf
#  Call Method   ${profile}   set_preference   browser.helperApps.neverAsk.saveToDisk   application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/pdf
#  Call Method   ${profile}   set_preference   pdfjs.disabled  ${True}
#  Create WebDriver   ${USERS.users['${username}'].browser}   alias=${my_alias}   firefox_profile=${profile}
#  Go To   ${USERS.users['${username}'].homepage}
