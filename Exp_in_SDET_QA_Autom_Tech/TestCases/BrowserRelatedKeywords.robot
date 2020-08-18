#https://www.youtube.com/watch?v=LY87JHkIBzo&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=10 lesson 10



*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${url_g}  https://www.google.com/
${url_bing}  https://www.bing.com/


*** Test Cases ***
NavigationTest
    open browser    ${url_g}    ${browser}
    ${location}=    get location  #запише урл актуального браузера
    log to console  ${location}
    sleep   2


    go to   ${url_bing}     #перейде за посиланням в бін
    ${location}=    get location  #запише урл актуального браузера
    log to console  ${location}

    #а тепер повернемося назад до посилання гугла
    go back   #імітує батон назад в браузері
    ${location}=    get location  #запише урл актуального браузера
    log to console  ${location}

    close browser
