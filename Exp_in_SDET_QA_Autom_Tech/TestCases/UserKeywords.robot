
# lesson 13 https://www.youtube.com/watch?v=Ar-iQnvahxQ&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=13


*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${login}    test@test17.com
${psw}  test@test17.com
${url}  http://practice.automationtesting.in/my-account/


*** Test Cases ***
UserKeywordTC
    LaunchBrowserChrome_with_no_argiments   #використовуємо кейворб і НЕ передаємо ніяких параметрів/аргументів
    input text  xpath://input[@id='username']  ${login}
    input password  xpath://input[@id='password']   ${psw}
    close browser


    LaunchBrowserChrome_with_two_arguments  ${url}  ${browser}
    input text  xpath://input[@id='username']  ${login}
    input password  xpath://input[@id='password']   ${psw}
    close browser


    ${page_title}=   LaunchBrowserChrome_with_two_arguments_and_retunr_the_value  ${url}  ${browser}
    log to console  ${page_title}
    input text  xpath://input[@id='username']  ${login}
    input password  xpath://input[@id='password']   ${psw}
    close browser




*** Keywords ***
LaunchBrowserChrome_with_no_argiments     #створимо свій кейворд в який не будемо передавати аргументи
    open browser    ${url}  ${browser}
    Maximize Browser Window

LaunchBrowserChrome_with_two_arguments      #кейворд в який передамо 2 аргументи
    [Arguments]  ${app_url}  ${app_browser}
    open browser    ${app_url}  ${app_browser}
    Maximize Browser Window


LaunchBrowserChrome_with_two_arguments_and_retunr_the_value      #кейворд в який передамо 2 аргументи
    [Arguments]  ${app_url}  ${app_browser}
    open browser    ${app_url}  ${app_browser}
    Maximize Browser Window
    ${page_title}=  get title   #збережемо велью в перемінну
    [Return]    ${page_title}    #повернемо велью із тайтла




