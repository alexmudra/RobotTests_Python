#https://www.selenium.dev/selenium/docs/api/java/  ресурс із 3ма фреймами

*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}  chrome

*** Test Cases ***
HandlingFrames
    Open Browser    https://www.selenium.dev/selenium/docs/api/java/    ${browser}

    select frame    name:packageListFrame       #можна вказати не тільки нейм але і id, xpath, name
    click link  org.openqa.selenium.chrome
    unselect frame

    select frame    name:packageFrame
    click link  ChromeDriverService.Builder
    unselect frame


    select frame    name:classFrame
    click link  Help
    click link  Deprecated
    click link  Frames
    unselect frame

