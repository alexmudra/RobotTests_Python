#https://www.youtube.com/watch?v=iYXl3MrRHDI&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=17
#Part 17- How to Handle Web/HTML Table in Robot Framework | Selenium with Python
#http://testautomationpractice.blogspot.com/






*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome

*** Test Cases ***
TableValidations
    open browser    http://testautomationpractice.blogspot.com/   ${browser}
    Maximize Browser Window
    ${rows_in_table}=   get element count   xpath://table[@name='BookTable']/tbody/tr  #порахуємо рядків в таблиці
    ${coloms_in_table}=   get element count   xpath://table[@name='BookTable']/tbody/tr[1]/th  #порахуємо колонок в таблиці

    log to console  "К-сть рядків" ${rows_in_table}
    log to console  ${coloms_in_table}
    sleep  2
    close browser




