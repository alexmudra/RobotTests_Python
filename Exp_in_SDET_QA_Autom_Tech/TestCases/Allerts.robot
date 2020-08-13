#ресурс де можна перевіряти алерти http://testautomationpractice.blogspot.com/
#https://www.youtube.com/watch?v=qAB11ABeezw&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=8 lesson 8

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
    #handle alert    leave

    alert should be present  Press a button!  #перевіряє текст в алерті
    alert should not be present  Press a button3211351!  #перевіряє відсутність тексту в алерті
