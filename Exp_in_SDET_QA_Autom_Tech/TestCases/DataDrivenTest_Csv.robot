#http://practice.automationtesting.in/my-account/
#https://www.youtube.com/watch?v=V9GMaX-y4pQ&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=19


*** Settings ***
Library    SeleniumLibrary
Resource   ../Resources/login_resourses.robot
Library    DataDriver   ../TestData/LoginData.csv

Suite Setup      Open My Browser  #відкриє браузер лише 1 раз перед запусками тесткейсів
Suite Teardown      Close Browsers      #цей кейворд буде виконоуватись після того як ТК закінчаться
Test Template       Invalid Login


*** Test Cases ***
TestLoginWithCVSFile           ${username}      ${password}



*** Keywords ***
Invalid Login
    [Arguments]     ${username}     ${password}
    Input User Name     ${username}
    Input Password      ${password}
    Click Login Button
    Error message should be visible






