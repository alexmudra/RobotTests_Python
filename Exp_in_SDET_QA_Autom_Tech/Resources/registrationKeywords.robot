#https://www.youtube.com/watch?v=DCgrW-i9cT8&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=23
#Part 23- Page Object Model (POM) Pattern in Robot Framework | Selenium with Python (start video from 30:26
*** Settings ***
Library      SeleniumLibrary
Variables   ../PageObjects/locators.py  #Variables вказуємо коли ресурс в пайтон файлі

*** Keywords ***

Open My Browser
    [Arguments]   ${siteUrl}     ${Browser}
    open browser  ${siteUrl}     ${Browser}
    Maximize Browser Window

Click register Link
  Click button  ${click_registration_bnt}

Select organizer
    [Arguments]  ${register_like}
    Select From List By Value   ${register_like}  1


Enter login
    [Arguments]   ${login}
    input text    enter_loginname    ${login}

Enter pass
    [Arguments]   ${pass}
    input text   ${enter_pass_first}  ${pass}
    input text   ${confirm_pass}  ${pass}


Enter value to login (kostil)
    input text   xpath://input[@id='user-username']    kjkjnkj




Close my browsers
    close all browsers

