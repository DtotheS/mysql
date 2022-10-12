# Lesson 3: Numeric and String Functions and Operators
USE classicmodels; # comment
SHOW tables; --  this is also comment

# 1. Numeric functions
## Round, Ceil, Floor
SELECT
	round(0.5), ## don't forget "," when use multiple elements. seperate lines does not have any meaning in SQL.
    ceil(0.2),
    floor(0.9);

SELECT * from products;

SELECT
	buyPrice,
    ROUND(buyPrice),
    round(buyPrice),
    ceil(buyPrice),
    floor(buyPrice)
FROM products;

## ABS: absolute number
SELECT abs(1), abs(-1), abs(3-10);

## (among numbers in parenthesis) Greatest, Least
SELECT 
  GREATEST(1, 2, 3),
  LEAST(1, 2, 3, 4, 5);

SELECT * FROM OrderDetails
where abs(quantityordered - 10) < 5;

SELECT * FROM orderdetails;
SELECT
  quantityordered, priceeach, orderlinenumber,
  GREATEST(quantityordered, priceeach, orderlinenumber),
  LEAST(quantityordered, priceeach, orderlinenumber)
FROM orderdetails;

## Max, Min, etc
/* This functions calculate based on column
MAX	
MIN	
COUNT (Exclude NULL values)
SUM	
AVG	
*/

SELECT
  MAX(Quantityordered),
  MIN(Quantityordered),
  COUNT(Quantityordered),
  SUM(Quantityordered),
  AVG(Quantityordered)
FROM OrderDetails
WHERE Ordernumber BETWEEN 10100 AND 10150;

## Power, square root
/*
POW(A, B), POWER(A, B)
SQRT
*/

SELECT
	pow(2,3),
    power(5,2),
    sqrt(15);

SELECT * FROM products;
select
	buyPrice, pow(buyPrice,1/2)
    FROM products
    where sqrt(buyPrice) <5;

# TRUNCATE(N,n) choose n digits from N
SELECT
  TRUNCATE(1234.5678, 1),
  TRUNCATE(1234.5678, 2),
  TRUNCATE(1234.5678, 3),
  TRUNCATE(1234.5678, -1),
  TRUNCATE(1234.5678, -2),
  TRUNCATE(1234.5678, -3);
  
SELECT buyPrice FROM products
where truncate(buyPrice,0)=91;

## More number related functions: https://dev.mysql.com/doc/refman/8.0/en/numeric-functions.html

# 2. String Functions

-- UCASE, UPPER
-- LCASE, LOWER

SELECT
	upper("abcDEF"),
    lower("abcDEF");

select * from customers;

SELECT
  UCASE(customername),
  LCASE(customername)
FROM customers;

## CONCAT(...,...,...)
## CONCAT_WS(S, ...) Concatenate elements within parenthesis with SAVEPOINT

SELECT concat('HELLO',' ','This is ',2021);
SELECT CONCAT_WS('-', 2021, 8, 15, 'AM');
show tables;
select * from orders;
SELECT CONCAT('O-ID: ', Ordernumber) FROM Orders;
select * from Employees;
SELECT
  CONCAT_WS(' ', FirstName, LastName) AS FullName
FROM Employees;

## SUBSTR, SUBSTRING("text",N,n) cut text from N and show only n chars
## LEFT("text",N)	from left N chars
## RIGHT("text",N) from right N chars

SELECT
  SUBSTR('ABCDEFG', 3), # all chars from 3rd char
  SUBSTR('ABCDEFG', 3, 2),
  SUBSTR('ABCDEFG', -4),
  SUBSTR('ABCDEFG', -4, 2);

SELECT
  LEFT('ABCDEFG', 3),
  RIGHT('ABCDEFG', 3);
  
SELECT
  OrderDate,
  LEFT(OrderDate, 4) AS Year,
  SUBSTR(OrderDate, 6, 2) AS Month,
  RIGHT(OrderDate, 2) AS Day
FROM Orders;

## Length
/*
LENGTH	byte length
CHAR_LENGTH, CHARACTER_LEGNTH	character length
*/

SELECT
  LENGTH('ABCDE'),
  CHAR_LENGTH('ABCDE'),
  CHARACTER_LENGTH('ABCDE');

SELECT
  LENGTH('안녕하세요'), -- 15
  CHAR_LENGTH('안녕하세요'), -- 5
  CHARACTER_LENGTH('안녕하세요'); -- 5

## Trim remove space
/*
TRIM	both left and right
LTRIM	remove left space
RTRIM	remove right space
*/

SELECT
  CONCAT('|', ' HELLO ', '|'),
  CONCAT('|', LTRIM(' HELLO '), '|'),
  CONCAT('|', RTRIM(' HELLO '), '|'),
  CONCAT('|', TRIM(' HELLO '), '|');

show tables;
SELECT * FROM products
WHERE productline = ' motorcycles '; # space is matter.

SELECT * FROM products
WHERE productline = trim(' motorcycles ');

## PAD
/*
LPAD(S, N, P)	S가 N글자가 될 때까지 P를 이어붙임
RPAD(S, N, P)	S가 N글자가 될 때까지 P를 이어붙임
*/

SELECT
  LPAD('ABC', 5, '-'),
  RPAD('ABC', 5, '-');

select * from products;
SELECT
  LPAD(productCode, 10, "S"),
  RPAD(quantityinstock, 4, 0)
FROM Products;

## REPLACE(S, A, B)	Replace from A to B among S
SELECT
  REPLACE('ABCDEFG', 'CD', 'HI');

SELECT
  productscale,
  REPLACE(productscale, ':', ' to ')
FROM products;

## INSTR(S, s)	instring return the first position where s comes out in S, if not, then return 0
SELECT
  INSTR('ABCDE', 'ABC'),
  INSTR('ABCDE', 'BCDE'),
  INSTR('ABCDE', 'C'),
  INSTR('ABCDE', 'DE'),
  INSTR('ABCDE', 'F');
  
SELECT * FROM Customers
WHERE INSTR(CustomerName, ' ') BETWEEN 1 AND 6; # find whose first name is shorter than 6.
-- if we use "< 6"? then it will contain cases where there is no space (=0). This will give very long first name with no last name case.

## CAST(A, T)	change A to T datatype
SELECT
  '01' = '1', #01 and 1 are two different texts, so it is false.
  CONVERT('01', DECIMAL) = CONVERT('1', DECIMAL); # change to decimal type. then it is true.
  
## more string-functions: https://dev.mysql.com/doc/refman/8.0/en/string-functions.html