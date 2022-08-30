# Lesson 4. Time/Date Functions and Operators
use classicmodels;

## 1. Time/Date Functions
/*
CURRENT_DATE, CURDATE	return current date
CURRENT_TIME, CURTIME	return current date
CURRENT_TIMESTAMP, NOW	return current time and date
*/

SELECT CURDATE(), CURTIME(), NOW();

/*
DATE	Convert given text ('yyyy-mm-dd' or 'yy-mm-dd') to date
TIME	Convert given text ('yyyy-mm-dd') to time
*/

select DATE('2022-8-1'); # give date
select DATE('22-8-1'); # give date
select DATE('8-1-2022'); # null
SELECT DATE('08/01/2022'); # null

SELECT
	'2022-8-1' = '2022-08-01',
    DATE('2022-8-1') = DATE('2022-08-01'),
    '1:2:3' = '01:02:03',
    TIME('1:2:3')=TIME('01:02:03'),
    DATE("8/1/2022") = DATE("2022-8-1"); #mm/dd/yyyy gives null value

SELECT DATE('2022-6-1 1:2:3'); # only extract date
SELECT TIME('2022-6-1 1:2:3'); # only extract time

SELECT
  '2022-6-1 1:2:3' = '2022-06-01 01:02:03',
  DATE('2022-6-1 1:2:3') = DATE('2022-06-01 01:02:03'),
  TIME('2022-6-1 1:2:3') = TIME('2022-06-01 01:02:03'),
  DATE('2022-6-1 1:2:3') = TIME('2022-06-01 01:02:03'),
  DATE('2022-6-1') = DATE('2022-06-01 01:02:03'),
  TIME('2022-6-1 1:2:3') = TIME('01:02:03');

show tables;
select * from orders;

SELECT * FROM Orders
WHERE
  OrderDate BETWEEN DATE('2003-1-1') AND DATE('2003-1-31'); #containing start & end date in the data.
    
/*
YEAR	return year of DATETIME value from given text (i.e., yyyy-mm-dd)
MONTHNAME	return month(english) ~
MONTH	return month(number) ~
WEEKDAY	return weekday(Monday:0) ~
DAYNAME	return day(english) ~
DAYOFMONTH, DAY	return day(number) ~
*/

SELECT
  OrderDate,
  YEAR(OrderDate) AS YEAR,
  MONTHNAME(OrderDate) AS MONTHNAME,
  MONTH(OrderDate) AS MONTH,
  WEEKDAY(OrderDate) AS WEEKDAY, #Monday:0 ~ Saturday:6
  DAYNAME(OrderDate) AS DAYNAME,
  DAY(OrderDate) AS DAY
FROM Orders;

SELECT
  OrderDate,
  CONCAT(
    CONCAT_WS(
      '/',
      YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate)
    ),
    ' ',
    UPPER(LEFT(DAYNAME(OrderDate), 3))
  )
FROM Orders;

SELECT * FROM Orders WHERE WEEKDAY(OrderDate) = 0;

/*
HOUR	return hour from datetime
MINUTE	return minute
SECOND	return second
*/

SELECT
  HOUR(NOW()), MINUTE(NOW()), SECOND(NOW());
select hour('300:2:3');

/*
ADDDATE, DATE_ADD	add time/date
SUBDATE, DATE_SUB	subtract time/date
*/

SELECT 
  ADDDATE('2022-06-20', INTERVAL 1 YEAR), # should include "INTERVAL + number + define name"
  ADDDATE('2022-06-20', INTERVAL 1 YEAR),
  ADDDATE('2022-06-20', INTERVAL -2 MONTH),
  ADDDATE('2022-06-20', INTERVAL 3 WEEK),
  ADDDATE('2022-06-20', INTERVAL -4 DAY),
  ADDDATE('2022-06-20', INTERVAL -5 MINUTE),
  ADDDATE('2022-06-20 13:01:12', INTERVAL 6 SECOND);

/*
DATEDIFF	**days** difference between two time/date
TIMEDIFF	**time (hh:mm:ss)** difference between two time/date
*/

SELECT
	orderdate,
    now(),
    datediff(orderdate,now()),
    timediff(orderdate,now()) # give null because orderdate does not contain time
from orders;

SELECT TIMEDIFF('2022-06-21 15:20:35', '2022-06-21 16:34:41');

SELECT * FROM Orders
WHERE
  ABS(DATEDIFF(OrderDate, '2004-1-1')) < 30; #less than 30 days
  
/*
LAST_DAY	last date(yyyy-mm-dd) of the month
*/

SELECT
  OrderDate,
  LAST_DAY(OrderDate),
  DAY(LAST_DAY(OrderDate)),
  DATEDIFF(LAST_DAY(OrderDate), OrderDate)
FROM Orders;

/*
Function:
DATE_FORMAT(datetime, converted)	date/time format converter

Format information:
%Y	yyyy
%y	yy
%M	Month name
%m	Month number
%D	Day name(1st, 2nd, 3rd...)
%d, %e	Day number (01 ~ 31)
%T	hh:mm:ss
%r	hh:mm:ss AM/PM
%H, %k	hour (~23)
%h, %l	hour (~12)
%i	minute
%S, %s	second
%p	AM/PM
%a	Abbreviated weekday name (Sun..Sat)
more: https://www.w3resource.com/mysql/date-and-time-functions/mysql-date_format-function.php
*/

SELECT
  DATE_FORMAT(NOW(), '%M %D, %Y %T'), # note that text and format can be mixed within one quote(" ").
  DATE_FORMAT(NOW(), '%y-%m-%d %h:%i:%s %p'),
  DATE_FORMAT(NOW(), '%Y년 %m월 %d일 %p %h시 %i분 %s초');
  
SELECT
	date_format(NOW(), '%m/%d/%Y (%a), %h-%i-%s %p');

SELECT REPLACE(
  REPLACE(
    DATE_FORMAT(NOW(), '%Y년 %m월 %d일 %p %h시 %i분 %초'),
    'AM', '오전'
  ),
  'PM', '오후'
);

/*
STR_TO_DATE(S, F)	create datetime from S using F format
*/

SELECT
  DATEDIFF(
    STR_TO_DATE('2022-06-04 07:48:52', '%Y-%m-%d %T'),
    STR_TO_DATE('2022-06-01 12:30:05', '%Y-%m-%d %T')
  ),
  TIMEDIFF(
    STR_TO_DATE('2022-06-04 07:48:52', '%Y-%m-%d %T'),
    STR_TO_DATE('2022-06-01 12:30:05', '%Y-%m-%d %T')
  );
  
select DATE('8/1/2022'); # Null
select str_to_date('8/1/2022','%m/%d/%Y'); #datetime

SELECT
  OrderDate,
  DATEDIFF(
    STR_TO_DATE('2003-01-01 13:24:35', '%Y-%m-%d %T'),
    OrderDate
  ),
  TIMEDIFF(
    STR_TO_DATE('2003-01-01 13:24:35', '%Y-%m-%d %T'),
    STR_TO_DATE(CONCAT(OrderDate, ' ', '00:00:00'), '%Y-%m-%d %T')
  )
FROM Orders;

## more date/time functions: https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

## 2. Other Functions

/*
IF(condition, T, F)	If the condition true, then return T, otherwise F
*/

SELECT IF (1 > 2, '1 is bigger than 2', '1 is smaller than 2.');

-- CASE ~~~ END: multiple conditions
SELECT
CASE
  WHEN -1 > 0 THEN '-1 is positive.'
  WHEN -1 = 0 THEN '-1 is zero.'
  ELSE '-1 is negative.'
END;

show tables;
select * from products;

SELECT 
    buyPrice,
    IF(buyPrice > 50, 'Expensive', 'Cheap'),
    CASE
        WHEN buyPrice < 30 THEN 'low'
        WHEN buyPrice BETWEEN 30 AND 50 THEN 'normal'
        ELSE 'high'
    END
FROM
    Products;

/*
IFNULL(A, B)	If A is null, then print B
*/

SELECT
	ifnull('A','B'),
    ifnull(NULL,'B');
    
select ifnull(buyPrice,'nnnnnn') from products; # when select column, we can use ifnull.
