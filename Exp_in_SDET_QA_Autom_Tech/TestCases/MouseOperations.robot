#http://swisnl.github.io/jQuery-contextMenu/demo.html ресурс для вивчення визову контекстного меню
#http://testautomationpractice.blogspot.com/
# lesson 12 https://www.youtube.com/watch?v=tf1ItrNE0nM&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=12
#Part 12- How to perform Mouse Operations in Robot Framework | Selenium with Python


*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${login}    test@test17.com
${psw}  test@test17.com

*** Test Cases ***
MauseActionsTC
    open browser    http://swisnl.github.io/jQuery-contextMenu/demo.html    ${browser}
    #імітуємо правий клік мишкою ==rignt click/open context menu
    open context menu   xpath://span[@class="context-menu-one btn btn-neutral"]
    sleep  3


    #double click action
    #http://testautomationpractice.blogspot.com/ - ресурс для тестування
    go to   http://testautomationpractice.blogspot.com/
    Maximize Browser Window

    double click element   xpath://button[contains(text(),"Copy Text")]
    Maximize Browser Window

    #drug and drop action
    go to   http://dhtmlgoodies.com/scripts/drag-drop-custom/demo-drag-drop-3.html





    close browser



