#https://www.youtube.com/watch?v=DCgrW-i9cT8&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=23
#Part 23- Page Object Model (POM) Pattern in Robot Framework | Selenium with Python
*** Settings ***
Library      SeleniumLibrary
Variables    ../PageObjects/Locators.py

Open My Browser
    [Arguments]   ${siteUrl}     ${Browser}
    open browser  ${siteUrl}     ${Browser}
    Maximize Browser Window

Enter My UserName
    [Arguments]     ${username}
    input text      ${txt_login_userName}   ${username}

Enter My Password
    [Arguments]     ${password}
    input text      ${txt_login_password}  ${password}


Click SingIn Btn
    click button    ${btn_signIn}


Verify Succesfull Login
    Page Should Contain Textfield      Кабінет користувача

Close my browsers
    close all browsers
