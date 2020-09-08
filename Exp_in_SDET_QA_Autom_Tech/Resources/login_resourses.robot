#https://www.youtube.com/watch?v=xoZ36eh8V2A&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=18
#Part 18- Data Driven Testing Using Script in Robot Framework | Selenium with Python




*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${LOGIN URL}    http://practice.automationtesting.in/my-account/
${BROWSER}      chrome

*** Keywords ***
Open my Browser
    open browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window


Close Browsers
    Close All Browsers


Open Login Page
    go to   ${LOGIN URL}


Input User Name
    [Arguments]     ${username}
    input text  id:username


Input Password
    [Arguments]     ${password}
    input text      id:password     ${password}


Click Login Button
    click element   xpath://input[@name='login']


Click Log Out
    click link   xpath://a[contains(text(),'Logout')]


Error message should be visible
    page should contain     Error: Password is required.


Page should conrain
    page shold contain  Dashboard

