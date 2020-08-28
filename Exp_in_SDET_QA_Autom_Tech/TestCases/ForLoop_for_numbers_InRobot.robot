
#https://www.youtube.com/watch?v=WXRpTnGg17Y&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=15
#Part 15- How to work with FOR loop in Robot Framework | Selenium with Python

# інфо як використовувати цикли FOR в роботі

*** Test Cases ***
FOR_Loop_UsingtTC1
    :FOR    ${i}    IN RANGE    1   10
    \   LOG TO CONSOLE  ${i}

    #${i} це ітератор/тимчасова перемінна якій буде присвоєно значення із range
    #IN RANGE означає в проміжку
    #1   10 - означає що виведуться значення  1-9 включно

FOR_Loop_UsingtTC2  #один пробіл між числами
    :FOR    ${i}    IN    1 2 3 4 5 6 7
    \   LOG TO CONSOLE  ${i}
    #такий буде вивід: FOR_Loop_UsingtTC                                                     1 2 3 4 5 6 7

FOR_Loop_UsingtTC3  #два пробіли між числами
    :FOR    ${i}    IN    1  2  3  4  5  6  7  8  9
    \   LOG TO CONSOLE  ${i}
    #якщо поставити 2 пробіла між числами то буде такий вивід FOR_Loop_UsingtTC3                                                    1
         #2
         #3
         #4
         #5
         #6
         #7
         #8
         #9
         #FOR_Loop_UsingtTC3


FOR_Loop_UsingtTC4  #створимо ліст із 5 чисел і прочитаємо його через фор
    @{items}    create list  1  2   3   4   5  #створили ліст із 5 чисел
    :FOR    ${i}    IN    @{items}
    \   LOG TO CONSOLE  "це число:" ${i}
    #FOR_Loop_UsingtTC4                                                    ."це число:" 1
         #"це число:" 2
         #"це число:" 3
         #"це число:" 4
         #"це число:" 5
         #FOR_Loop_UsingtTC4                                                    | PASS |
         #------------------------------------------------------------------------------




