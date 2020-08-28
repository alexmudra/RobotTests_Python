#https://www.youtube.com/watch?v=WXRpTnGg17Y&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=15
#Part 15- How to work with FOR loop in Robot Framework | Selenium with Python

# інфо як використовувати цикли FOR в роботі

*** Test Cases ***
FOR_Loop_for_strings_1
    :FOR  ${i}  IN  Alex  david  Tanya  Vera
    \   LOG TO CONSOLE  ${i}
    #FOR_Loop_for_strings                                                  Alex
         #david
         #Tanya
         #Vera
         #FOR_Loop_for_strings

FOR_Loop_for_strings_2  #роздрукуємо в рядок
    :FOR  ${i}  IN  Alex david Tanya Vera
    \   LOG TO CONSOLE  ${i}
    #------------------------------------------------------------------------------
         #FOR_Loop_for_strings_2                                                Alex david Tanya Vera
         #FOR_Loop_for_strings_2                                                | PASS |

FOR_Loop_for_strings_3  #роздрукуємо імена із ліста почерзі
    @{name_list}  create list  Kalyan Aleg Gallya
    :FOR  ${i}  IN  @{name_list}
    \   LOG TO CONSOLE  ${i}
    #------------------------------------------------------------------------------
         #FOR_Loop_for_strings_3                                                .Kalyan Aleg Gallya
         #FOR_Loop_for_strings_3                                                | PASS |
         #------------------------------------------------------------------------------

FOR_loop_with_exit_in_letter  #вийдемо із циклу якщо буде умова в ТРУ
    @{abc_items}  create list  a  b  c
    :FOR  ${i}  IN   @{abc_items}
    \   LOG TO CONSOLE  ${i}
    \   exit for loop if   ${i}==b  #виходимо із лупа якщо і/ітератор буде дорівнювати 5
    #FOR_loop_with_exit                                                    .1
         #2
         #3
         #4
         #5
         #FOR_loop_with_exit                                                    | PASS |




