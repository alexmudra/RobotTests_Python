#https://www.youtube.com/watch?v=GRwMCKdzJGM&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=20
#офсайт лібри для роботи із дб https://franz-see.github.io/Robotframework-Database-Library/api/0.5/DatabaseLibrary.html

*** Settings ***
Library  DatebaseLibrary
Library  OperatingSystem

#виконається тільки 1 раз перед запуском Тк - підконектитись до MySQL + обявимо декілька перемінних/аргументів
Suite Setup         Connect To Database     pymysql     ${DBName}   ${DBUser}   ${DBPAss}   ${DBHost}   ${DBPort}

#через теардаут потрібно відконектитись від бази даних
Suite Teardown      Disconnect From Database

*** Variables ***
${DBName}       mydb
${DBUser}       root
${DBPAss}       root
${DBHost}       127.0.0.1   #це дефолтне значення і можна записати інше, можна прописати адресу іншого хоста бд
${DBPort}       3306        #це дефолтне значення і можна записати інше

*** Test Cases ***
#офсайт лібри для роботи із дб https://franz-see.github.io/Robotframework-Database-Library/api/0.5/DatabaseLibrary.html
Create person title
    #створимо нову таблицю в бд через запит і перемінну і перевіримо чи створилася таблиця
    ${output}=  Execute SQL String  Create table person(id integer, First_name varchar(20),Last_name varchar(20))
    log to console  ${output}       #після створення таблиці система виведе що таблиця це none
    should be equal as strings  ${output}   None  #якщо повернуло нон, то із таблицею все ок

#перевіримо чи норм дані записалися в таблицю
Insert Data In Person Table
    #додамо одну стрінгу із даними в таблицю person
    #${output}=  Execute SQL String  Insert into person values(101, "Alex", "K");
    #${output}=  Execute SQL String  Insert into person values(101, "Alex", "K");
    #log to console  ${output}       #після створення таблиці система виведе що таблиця це none
    #should be equal as strings  ${output}   None  #якщо повернуло нон, то із таблицею все ок

    #додамо 5 даних в бд із sql таблиці -- так звані insertion tests
    ${output}=  Execute SQL Script  ../TestData/myDB_with_persons_insertData.sql
    log to console  ${output}       #після створення таблиці система виведе що таблиця це none
    should be equal as strings  ${output}   None  #якщо повернуло нон, то із таблицею все ок


    #перевіримо чи є записане велью в бд
Check Alex record in DB present
    Check If Exists In Database     select id from mydb.person where first_name="Alex";




