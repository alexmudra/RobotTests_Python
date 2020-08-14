#хороший сайт для тестування елементів http://demo.automationtesting.in/Windows.html
# lesson 9 https://www.youtube.com/watch?v=5tVgC-oQVKs&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=9
# Part 9- How to Handle Tabbed Windows & Browser Windows | RobotFramework | Selenium with Python


*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome
${url}  http://demo.automationtesting.in/Windows.html


*** Test Cases ***
TabbedWindowsTast
    open browser   ${url}  ${browser}
    Maximize Browser Window
    click element    xpath://button[@class="btn btn-info"]
    #вибираємо вікно у другій вкладці
    Select Window   url=http://www.sakinalium.in/  #обов'язково треба ставити вкінці урл слеш
    sleep   3
    close all browsers


