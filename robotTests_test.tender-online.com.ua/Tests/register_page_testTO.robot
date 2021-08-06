*** Settings ***
Library     SeleniumLibrary
Resource    ../TestData/ConfigData.robot
Resource    ../Resources/common.robot
#Resource    C:/Users/alex/PycharmProjects/RobotTests_Python/robotTests_test.tender-online.com.ua/Resources/common.robot
Resource    ../Resources/locators_variables_test_to.robot

Suite Setup     common.Start TestCase
Suite Teardown  common.Finish TestCase
Test Template   Перевірка сторінки реєстрації після переходу

*** Keywords ***

Перевірка сторінки реєстрації після переходу
    [Arguments]   ${register_page}  ${msg}
    ${url}=     get location
    Should Be True    '${url}' in '${register_page}'    msg=${msg}
    log to console  ${msg}


*** Test Cases ***
Звірити лінк сторінки реєстрації після переходу на ресурс:${register_page}   ${register_page}   ${msg_identical}

