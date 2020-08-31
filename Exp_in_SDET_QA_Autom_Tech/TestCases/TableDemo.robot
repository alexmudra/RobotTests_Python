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
    log to console  "К-сть стопчиків" ${coloms_in_table}
    sleep  2
    close browser

GetTextValueInTable
    open browser    http://testautomationpractice.blogspot.com/   ${browser}
    Maximize Browser Window
    ${get_text_data}=   get text  xpath://table[@name='BookTable']/tbody/tr[5]/td[1]   #вивели дані через get text
    log to console  "Це інфо із колонки:" ${get_text_data}
    sleep  1
    close browser



#verifation the values in table
GetTableValues
    open browser    http://testautomationpractice.blogspot.com/   ${browser}
    Maximize Browser Window
    table column should contain  xpath://table[@name='BookTable']   2   Author
    table column should contain  xpath://table[@name='BookTable']/tbody/tr[1]/th[2]     4   Price

    #перевірити чи є в рядку(row) певне значення
    table row should contain  xpath://table[@name='BookTable']/tbody/tr[1]/th[2]     4   Learn JS

    #перевіримо чи є в певному рядку і колонці(перетин)/cell ячейка значення
    ${cell_should_have_value}=  table cell should contain  xpath://table[@name='BookTable']  5  2  Mukesh
    log to console  "Комірка має таке значення:" ${cell_should_have_value}

    #перевірити що має хедер таблиці
    table header should contain  xpath://table[@name='BookTable']    BookName

    sleep  1
    close browser


