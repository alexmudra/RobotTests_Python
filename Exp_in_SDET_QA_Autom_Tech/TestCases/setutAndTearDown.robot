#https://www.youtube.com/watch?v=tKS7lXwDs9k&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=21
#Part 21- Setup & TearDown in Robot FrameworkRobot | Selenium with Python


*** Settings ***

Suite Setup  log to console     Opening Drowser  #виконається 1 раз перед стартом суіта
Suite Teardown  log to console     Closing Drowser      #виконається після закінчення суіта 1 раз


Test Setup      log to console  Login to application   #буде виконуватись завжди перед стартом тесткейса
Test Teardown   log to console      Logout fron application  #буде завжди виконуватись кожного разу після зак-ня тесткейса