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
RegistrationTestWithImplicitWait
    ${implicit_wait}=   Get Selenium Implicit Wait
    Log To Console   ${implicit_wait}    #виводимо значення затримки селеніума на екран (дефолтно значення буде 0)
#    Set Selenium Speed  1
    Open Browser    ${url}  ${browser}

    #так визначається імплісіт вейт і буде діяти для кожної команди внизу
    Set Selenium Implicit Wait  10seconds  #задали очікування в 10 секунд. Якщо елемент не з'явиться на екрані протягом
    #10 секунд то отримаєм приблизно такий нотіфікайшн Text 'Реєст7рація на майданчику' did not appear in 10 seconds.
    #Імплісіт вейт це найбільш протуктивний кейворд для використання


    ${selenium_timeout}=    Get Selenium Speed
    Log To Console  ${selenium_timeout}

    Set Selenium Timeout    10seconds
    Wait Until Page Contains    Реєстрація на майданчику        #дефолтно селеніум буде чекати на текст 5 секунд
    #якщо дефолтних 5 сек замало то можна зверху над кондішіном поставити  Set Selenium Timeout    10seconds

    Select From List By Index   companies-customer_type     5
    Input Text  id:user-username    ${email}
    Input Password  id:user-password    ${pass}
    Input Password  id:user-confirmpassword    ${pass}
    Select From List By Index   companies-registrationcountryname  1





*** Keywords ***