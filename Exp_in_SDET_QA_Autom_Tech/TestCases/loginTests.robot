*** Settings ***
Library      SeleniumLibrary
Resource     ../Resources/loginKeywords.robot      #Resource вказуємо коли ресурси робот файлі

*** Variable ***
${Browser}  chrome
${SiteUrl}  http://eauction.byustudio.in.ua/login
${user}     ustudiotesti.ng@gmail.com
${pwd}      ustudiotesti.ng@gmail.com


*** Test Cases ***
LoginTest
    Open My Browser     ${SiteUrl}  ${Browser}
    Enter My UserName   ${user}
    Enter My Password   ${pwd}
    Click SingIn Btn
    sleep  3 seconds
    Verify Succesfull Login
    sleep  3
    Close my browsers





