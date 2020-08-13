#ресурс де можна перевіряти алерти http://testautomationpractice.blogspot.com/

*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome

*** Test Cases ***
HandlingAllerts

    open browser    http://testautomationpractice.blogspot.com/     ${browser}
    click button    xpath://button[contains(text(),'Click Me')]  #цей клік відкриє алерт-вікно із ок чи кансел
    sleep   3

    #для того щоб підтвердити алерт-вікно(ніби клікнути ок) треба використати наступний кейворд
    #handle alert    accept

    #для того щоб відмінити алерт-вікно(ніби клікнути ок) треба використати наступний кейворд
    #handle alert    dismiss

    #для того щоб залишити алерт-вікно(ніби клікнути ок) треба використати наступний кейворд
    handle alert    leave