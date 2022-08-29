# !pip install mysql-connector-ipython

import mysql.connector

mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='ektlsThr10075%'
)

# print(mydb)

mycursor = mydb.cursor()
mycursor.execute("SHOW DATABASES")
for x in mycursor:
    print(x)

mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='',
    database='classicmodels'
)

mycursor = mydb.cursor()
mycursor.execute("SELECT * FROM customers")
myresult = mycursor.fetchall()

for x in myresult:
    print(x)