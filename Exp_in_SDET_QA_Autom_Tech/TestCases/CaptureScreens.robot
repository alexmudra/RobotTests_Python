
#https://www.youtube.com/watch?v=wW4xdTvRbGw&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=11
#Part 11- How to Capture Element & Full Page Screenshot | RobotFramework | Selenium with Python


*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${login}    test@test17.com
${psw}  test@test17.com
${url_e}  http://eauction-dev.byustudio.in.ua/
${url_pr}   http://practice.automationtesting.in/my-account/

*** Test Cases ***
LoginTestCuptureScreen
    open browser    ${url_pr}   ${browser}
    input text  id:username     ${login}
    input text  id:password     ${psw}

    #зробимо скріншот всієї сторінки і збережемо в папку із розширенням png
    Capture Page Screenshot     /home/alex/PycharmProjects/Exp_in_SDET_QA_Autom_Tech/TestCases/screen.png
    #зробимо скріншот і збережемо подефолту
    Capture Page Screenshot     screenshotLoginPage.png


