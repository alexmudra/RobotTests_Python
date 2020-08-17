# lesson 9 https://www.youtube.com/watch?v=5tVgC-oQVKs&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=9
# Part 9- How to Handle Tabbed Windows & Browser Windows | RobotFramework | Selenium with Python



*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${url_g}  https://www.google.com/
${url_t_ps}  https://test.prozorro.sale/


*** Test Cases ***
SwitchToMultBrowsers
    open browser    https://www.google.com/     chrome  #open google ling in first browser
#    sleep   3

    open browser    ${url_t_ps}     ${browser} #open secont browser

    switch browser  1   #переключатися між браузерами можна через аргумент індекси ( н-д: 1, 2,3)
    ${title1}=   get title  #запишемо в перемінну значення із тайтлу
    log to console  ${title1}

    switch browser  2
    ${title2}=   get title  #запишемо в перемінну значення із тайтлу
    log to console  ${title2}










