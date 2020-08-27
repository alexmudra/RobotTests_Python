
# lesson 13 https://www.youtube.com/watch?v=Ar-iQnvahxQ&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=13


*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/resources.robot       #

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

    LaunchBrowserChrome_with_two_arguments  ${url}  ${browser}
    input text  xpath://input[@id='username']  ${login}
    input password  xpath://input[@id='password']   ${psw}

    ${page_title}=   LaunchBrowserChrome_with_two_arguments_and_retunr_the_value  ${url}  ${browser}
    log to console  ${page_title}
    input text  xpath://input[@id='username']  ${login}
    input password  xpath://input[@id='password']   ${psw}

    close all browsers







