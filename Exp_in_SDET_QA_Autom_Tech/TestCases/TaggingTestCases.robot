#https://www.youtube.com/watch?v=sdFmuhYNp38&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=22
#Part 22- Tags | Grouping Tests in Robot FrameworkRobot | Selenium with Python


#тут пояснюється як запускати тести по тегам (групами) (через теги н-д: [Tags]  sanity), щоб не запускати їх всі

*** Settings ***


*** Test Cases ***
TC1 User Resistration test
    [Tags]  sanity
    log to console  This is user registration test
    log to console  User reg test is finished

TC2 Login Test
    [Tags]  regression
    log to console  This is login test
    log to console  Login Test is finished

TC3 Chgange user settings
    [Tags]  sanity
    log to console  This is changins user settings test
    log to console  Change user settings test is over

TC4 Logout Test
    [Tags]  regression
    log to console  This is log out test
    log to console  Logout test is over

#щоб запустити ТК тільки із тегом sanity, то потрібно запускати команду в терміналі:
#(venv) alex@alex-Linux-PC:~/PycharmProjects/Exp_in_SDET_QA_Autom_Tech/TestCases$ robot --include=sanity TaggingTestCases.robot


#для того щоб запустити декілька тегів то треба запустити в терміналі таку команду
#(venv) alex@alex-Linux-PC:~/PycharmProjects/Exp_in_SDET_QA_Autom_Tech/TestCases$ robot -i regression -i sanity  TaggingTestCases.robot


#для того щоб виключити із запуску якісь ТК(по тегу), то треба прописати наступну команду
#(venv) alex@alex-Linux-PC:~/PycharmProjects/Exp_in_SDET_QA_Autom_Tech/TestCases$ robot -e regression TaggingTestCases.robot

#для того щоб включити (-і флаг) і виключити( -e флаг) із запуску одночасно декільа ТК (по тегам) то треба запустити таку команду
#(venv) alex@alex-Linux-PC:~/PycharmProjects/Exp_in_SDET_QA_Autom_Tech/TestCases$ robot -i regression -e sanity TaggingTestCases.robot
