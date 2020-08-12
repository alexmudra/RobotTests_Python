# link to lesson https://www.youtube.com/watch?v=TeK_X--r1BM&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=6

#стейтмент Sleep 3 означає що селеніум буде очікувати 3 секунди після кожного кроку
# якщо Set Selenium Speed 3 - то це аналаог сліпа проте пишемо 1 раз на початку ТК





*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${url}  http://eauction.byustudio.in.ua/register
${email}    organiz_neobrob_wood_stage@byustudio.in.ua
${pass}    organiz_neobrob_wood_stage@byustudio.in.ua

*** Test Cases ***
RegistrationTest
#    ${speed}=   Get Selenium Speed
#    Log To Console  ${speed}    #виводимо значення швидкості селеніума на екран (дефолтно значення буде 0)
#    Set Selenium Speed  1
    Open Browser    ${url}  ${browser}
    Set Selenium Timeout    10seconds
    Wait Until Page Contains    Реєстрація на майданчику        #дефолтно селеніум буде чекати на текст 5 секунд
    Select From List By Index   companies-customer_type  6
    Input Text  id:user-username    ${email}
    Input Password  id:user-password    ${pass}
    Input Password  id:user-confirmpassword    ${pass}
    Select From List By Index   companies-registrationcountryname  1

    Sleep   2

    Close Browser


*** Keywords ***