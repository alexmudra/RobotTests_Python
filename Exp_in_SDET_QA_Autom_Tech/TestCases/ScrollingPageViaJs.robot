#https://www.youtube.com/watch?v=N-_t3MvsWaY&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=14 -- урок 14

*** Settings ***
Library  SeleniumLibrary



*** Test Cases ***
ScrollingTest
    open browser    https://www.worldometers.info/geography/how-many-countries-are-there-in-the-world/  chrome
    #щоб проскролити сторінку виконаєм скріп джаваскріпт

    #execute javascript      window.scrollTo(0,4000)  #проскролить сторінку на 4000 пікселів вниз

    #scroll element into view  xpath://a[contains(text(),'Ukraine')]    вже не актуальний кейворд

    #wait until page contains element  xpath://a[contains(text(),'Ukraine')]
    #click link  href:world-population/ukraine-population

    #через джиес проскролиди донизу сторінки (document.body.scrollHeight)
    execute javascript      window.scrollTo(0,document.body.scrollHeight)
    sleep  3

    #проскролим через дж на початкову точку сторінки - в хедер (-document.body.scrollHeight))
    execute javascript      window.scrollTo(0,-document.body.scrollHeight)

    sleep   3
    close browser
