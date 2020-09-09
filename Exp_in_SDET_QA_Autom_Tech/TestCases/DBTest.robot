#https://www.youtube.com/watch?v=GRwMCKdzJGM&list=PLUDwpEzHYYLsCHiiihnwl3L0xPspL7BPG&index=20
#офсайт лібри для роботи із дб https://franz-see.github.io/Robotframework-Database-Library/api/0.5/DatabaseLibrary.html

*** Settings ***
Library  DatebaseLibrary
Library  OperatingSystem

#виконається тільки 1 раз перед запуском Тк - підконектитись до MySQL + обявимо декілька перемінних/аргументів
Suite Setup     Connect To Database     pymysql     ${DBName}   ${DBUser}   ${DBPAss}   ${DBHost}   ${DBPort}

#через теардаут потрібно відконектитись від бази даних
Suite Teardown  Disconnect From Database

*** Variables ***
${DBName}   mydb
${DBUser}   root
${DBPAss}   root
${DBHost}   127.0.0.1   #це дефолтне значення і можна записати інше, можна прописати адресу іншого хоста бд
${DBPort}   3306        #це дефолтне значення і можна записати інше

*** Test Cases ***



