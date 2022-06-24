-- Lesson 1: SELECT overall

USE classicmodels; # comment
SHOW tables; -- this is also comment
SELECT * FROM employees;
SELECT * FROM customers;
DESC customers; -- same with show columns from
SHOW COLUMNS FROM customers; -- MUL = foreign key

-- SELECT
SELECT customerName from customers;
SELECT customername, phone, addressline1 from customers;
SELECT 1, 'hello', NULL FROM customers;

-- Where
SELECT * FROM orders
WHERE customernumber < 200;
SELECT * FROM orderdetails
WHERE quantityordered < 30;

-- Order By
SELECT * FROM customers
ORDER BY customername;
SELECT * FROM orderdetails
ORDER BY orderlinenumber asc, quantityordered desc;

-- limit {number of pass}, {number of bring}
-- limit {number of bring}
SELECT * FROM customers limit 11; -- will bring 11 samples
SELECT * FROM customers limit 10,2; -- will ignore 10 samples and bring 11th and 12th

-- AS:bring data with alias
desc customers;
SELECT * from customers;
SELECT
	customernumber as ID,
    customername as NAME,
    CONCAT(addressline1,addressline2) as ADDR_1, -- concat() returns NULL if any field contain NULL
    CONCAT_WS(' ',addressline1,addressline2) as ADDR_2 -- concat_ws does not return NULL even if any one field contain NULL. So this is much safer
FROM customers;

select country from customers;

SELECT
  Customernumber AS id, -- 'id' or id does not matter
  Customername AS 이름, -- can yuse other languages
  City AS '도시',
  Country AS '국가'
FROM Customers
WHERE
  City = 'London' OR Country = 'italy' -- lower vs upper capital does not matter
ORDER BY CustomerName desc -- default: asc
LIMIT 0, 4;

-- Lesson 2: Operations
/*
연산자 의미
+, -, *, /	각각 더하기, 빼기, 곱하기, 나누기
%, MOD	나머지
IS	양쪽이 모두 TRUE 또는 FALSE
IS NOT	한쪽은 TRUE, 한쪽은 FALSE
AND, &&	양쪽이 모두 TRUE일 때만 TRUE
OR, ||	한쪽은 TRUE면 TRUE
=	양쪽 값이 같음
!=, <>	양쪽 값이 다름
>, <	(왼쪽, 오른쪽) 값이 더 큼
>=, <=	(왼쪽, 오른쪽) 값이 같거나 더 큼
BETWEEN {MIN} AND {MAX}	두 값 사이에 있음
NOT BETWEEN {MIN} AND {MAX}	두 값 사이가 아닌 곳에 있음
IN (...)	괄호 안의 값들 가운데 있음
NOT IN (...)	괄호 안의 값들 가운데 없음
LIKE '... % ...'	0~N개 문자를 가진 패턴
LIKE '... _ ...'	_ 갯수만큼의 문자를 가진 패턴
*/



