*** Settings ***
Library      SeleniumLibrary
Resource     ../Resources/registrationKeywords.robot      #Resource вказуємо коли ресурси робот файлі

*** Variable ***
${Browser}  chrome
${SiteUrl}  http://eauction.byustudio.in.ua/register



*** Test Cases ***
Enter login via kostil
    Open My Browser  ${SiteUrl}  ${Browser}
    Enter value to login (kostil)




RegistrationTests
    Open My Browser     ${SiteUrl}  ${Browser}
    #Click register Link
    #Register Like       ${register_like}
    Enter login     sdkjfn@gmail.com
    Enter pass      1234567



#    Enter My UserName   ${user}
#    Enter My Password   ${pwd}
#    Click SingIn Btn
#    sleep  3 seconds
#    Verify Succesfull Login
    sleep  3
    Close my browsers


