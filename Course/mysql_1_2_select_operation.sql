# Lesson 1: SELECT overall

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

# Lesson 2: Operations
/*
연산자 의미
+, -, *, /	각각 더하기, 빼기, 곱하기, 나누기
%, MOD	나머지
div Quotient
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

-- arithematic operation
SELECT 1 + 2;
SELECT 5-2.5 as difference;
SELECT 3*(2+4)/2, 'hello';
select 10%3,10/3,10 div 3;

SELECT 'ABC' + 3; -- in mysql, text in arithematic operation treated as 0
SELECT "aa"*3;
SELECT '1' + '002'*3; -- text consisted of numbers treated as numbers

DESC orderdetails;
select * from orderdetails;
SELECT ordernumber + quantityordered FROM orderdetails;

desc products;
select productname, buyprice, buyprice/2 as halfprice, buyprice*0.8 as "20%discount" from products;

-- True/False operation
SELECT TRUE,FALSE,true,false;
SELECT !true, not 1, !false, not false;
select 0=true, 1=true,0=false,1=false; -- = is same with IS
select * from customers where true;
select * from customers where false;
select true is true, false is not true, (true is false) is not true;

select true and false, true && true, true or false, false || false; -- and : true only if both true. or: true if any one of two is true.
select 2+3 = 6 or 2*3=6;

SELECT 1 = 1, !(1 <> 1), NOT (1 < 2), 1 > 0 IS NOT FALSE, 2>=2; -- != is <> 
SELECT 'A' = 'A', 'A' != 'B', 'A' < 'B', 'A' > 'B';
SELECT 'Apple' < 'Banana' OR 1 = 2 IS FALSE; -- lexicographical order
SELECT 'a' = 'A'; -- uppper = lower true!

desc products;
SELECT
  ProductName, buyPrice,
  buyPrice > 50 AS EXPENSIVE,
  NOT buyPrice > 50 AS cheap
FROM Products;

SELECT 5 between 1 and 10; 
select 'banana' not between 'apple' and 'camera';

select * from orderdetails
where productcode between "s10" and "s20";

select 1 between 1 and 2; -- including 1 and 2

select * from customers
where customername between "b" and "c";

SELECT 1+2 in (2,3,4), 'hello' in (1,true,'hello');
SELECT * FROM customers
where city in ('torino','paris','portland','madrid');

SELECT
  'HELLO' LIKE 'hel%',
  'HELLO' LIKE 'H%',
  'HELLO' LIKE 'H%O',
  'HELLO' LIKE '%O',
  'HELLO' LIKE '%HELLO%', -- %: 0 ~ N characters. Note that % includes 0 characters.
  'HELLO' LIKE '%H',
  'HELLO' LIKE 'L%';

SELECT
  'HELLO' LIKE 'HEL__',
  'HELLO' LIKE 'h___O',
  'HELLO' LIKE 'HE_LO',
  'HELLO' LIKE '_____',
  'HELLO' LIKE '_HELLO',
  'HELLO' LIKE 'HEL_',
  'HELLO' LIKE 'H_O';

SELECT * FROM Employees
WHERE jobtitle LIKE '%mark%'; 

SELECT * FROM OrderDetails
WHERE productcode LIKE '%s18%'
