#http://practice.automationtesting.in/my-account/
#https://www.youtube.com/watch?v=V9GMaX-y4pQ&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=19


*** Settings ***
Library     SeleniumLibrary
Resource    ../Resources/login_resourses.robot
Library     DataDriver   C:\Users\alex\PycharmProjects\RobotTests_Python\Exp_in_SDET_QA_Autom_Tech\TestData\LoginData.xls    sheet_name=Sheet1

Suite Setup      Open My Browser  #відкриє браузер лише 1 раз перед запусками тесткейсів
Suite Teardown      Close Browsers      #цей кейворд буде виконоуватись після того як ТК закінчаться
Test Template       Invalid Login


*** Test Cases ***
TestLoginWithExelFile           ${username} and ${password}



*** Keywords ***
Invalid Login
    [Arguments]     ${username}     ${password}
    Input User Name     ${username}
    Input Password      ${password}
    Click Login Button
    Error message should be visible






