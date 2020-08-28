#https://www.youtube.com/watch?v=qqbgRXlX4w0&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=16
#Part 16- How to Count & Extract Link Texts in Robot Framework | Selenium with Python
#https://www.worldometers.info/geography/how-many-countries-are-there-in-the-world/ -- тут підрахуємо лінки

*** Settings ***
Library  SeleniumLibrary

*** Test Cases ***
GetAllLinksTest
    open browser    https://www.worldometers.info/geography/how-many-countries-are-there-in-the-world/  chrome
    Maximize Browser Window
    ${AllLinksCount}=  get element count  xpath://a    #порахуємо всі лінки по тегу а
    log to console  ${AllLinksCount}   #виведем кількість лінків в консоль
    #результат буде таким: GetAllLinksTest                                                       ...221
                           #GetAllLinksTest                                                       | PASS |

    @{LinkItems}    create list   #створимо пустий ліст щоб записати туди всі лінки через FOF loop

    :FOR    ${i}   IN RANGE    1   ${AllLinksCount}   #пройдемось ітератором по списку лінків від 1 до ...
    \   ${linkText}=  get text  xpath:(//a)[${i}]  #беремо тест по ікспасу і індексу який взяв ітератор (//a)[${i}]
    \   log to console  ${linkText}
    close browser



