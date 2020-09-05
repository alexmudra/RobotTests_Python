*** Settings ***
Library  SeleniumLibrary

#формуємо сьюіт який буде постійно запускатися
Resource    ../Resources/login_resourses.robot
Suite Setup     Open my Browser         #цей кейворд запуститься тільки 1 раз перед тим як запустяться тесткейси
Suite Teardown  Close Browsers      #цей кейворт запуститься 1 разі після того як всі тесткейси закінчаться
Test Template   Invalid Login   #цей кейворд буде запускатися кожного разу для кожного тесткейса


*** Test Cases ***      username  password
Right User Empty Pass     test@test17.com     ${EMPTY}
Right User Invalid Pwd       test@test17.com      sdfdsf
Wrong User Right Pwd         testdslkf            test@test17.com
Wrong User Empty Pwd         testdslkf            ${EMPTY}
Wrong User Wrong Pwd         testdslkf            ksdjfkj




*** Keywords ***
Invalid Login
    [Arguments]     ${username}     ${password}
    Input User Name     ${username}
    Input Password      ${password}
    Click Login Button
    Error message should be visible   #ми постійно очікуємо якщо цей тесткейс буде тру, то тесткейси пройдуть




