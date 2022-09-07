# Chapter 2
# Lesson 7: Join - Combine multiple tables
USE classicmodels;
show tables;

# 1. JOIN(INNER JOIN)
-- Return (or use) column(NOT NULL) which have values in both (or multiple) tables.
-- 'INNER 'is optional
-- SL: It seems that, when we do the (INNER) JOIN, distingtion between main table (FROM ~~) and subtables (JOIN ~~) are not that important. They can be easily changed. It works.

SELECT * FROM products;
select * from orders;
select * from orderdetails;

SELECT * FROM orders O 
JOIN orderdetails OS -- Add OS to O
ON O.ordernumber = OS.ordernumber; -- Using ordernumber

SELECT O.ordernumber, customernumber, OS.productcode FROM orders O -- We can remove O. from "O.customernumber" since it is not ambiguous (i.e. it is unique.) However, if we remove O. from ordernumber, then it will give ambigous error
JOIN orderdetails OS
ON O.ordernumber = OS.ordernumber;

select * from productlines;
select * from products;
select * from customers;

SELECT concat(P.productname, ': ', L.textdescription) as Product, L.productline, P.buyprice
FROM products P
JOIN productlines L
ON P.productline = L.productline
where P.buyprice > 60
ORDER BY productname;

## Join multiple (>3) tables
select * from productlines;
select * from products;
select * from orderdetails;
select * from orders;
select * from customers;

/*
OD - O - C
OD - P
*/
select O.ordernumber, C.customernumber, C.contactfirstname, OD.productcode, OD.priceeach, concat(contactLastName, ', ', contactfirstname) as Contact_Full_Name FROM orderdetails OD
JOIN orders O ON OD.ordernumber = O.ordernumber
JOIN products P ON OD.productcode = P.productcode
JOIN customers C ON C.customerNumber = O.customernumber;

select O.ordernumber, O.orderdate, OD.productcode, OD.priceeach FROM orders O
JOIN orderdetails OD ON OD.ordernumber = O.ordernumber; -- there is only one ordernumber in O, but multiple ordernumber in OD. In this case, it will make multiple rows and show all the possible combinations.

## JOIN & GROUP BY
select O.ordernumber, min(quantityordered) as minQ, max(quantityordered) as maxQ, avg(priceeach) as avgP
FROM orders O
JOIN orderdetails OD ON OD.ordernumber = O.ordernumber
JOIN products P ON OD.productcode = P.productcode
JOIN customers C ON C.customerNumber = O.customernumber
group by O.ordernumber;

select O.ordernumber, country, min(quantityordered) as minQ, max(quantityordered) as maxQ, avg(priceeach) as avgP
FROM orders O
JOIN orderdetails OD ON OD.ordernumber = O.ordernumber
JOIN products P ON OD.productcode = P.productcode
JOIN customers C ON C.customerNumber = O.customernumber
group by C.country, O.ordernumber; -- Order of group by does not matter.

## SELF JOIN - between SAME tables
select * from employees;
select * from offices;

SELECT
  E1.Employeenumber, CONCAT_WS(' ', E1.FirstName, E1.LastName) AS Employee,
  E2.Employeenumber, CONCAT_WS(' ', E2.FirstName, E2.LastName) AS NextEmployee
FROM Employees E1 JOIN Employees E2
ON E1.Employeenumber + 1 = E2.Employeenumber; -- since employee ID is NOT consecutive(e.g., 1,6,21,45), it is possible that no such case. Then, it will only return which satify the ON condition.ALTER


select O1.officecode, concat_ws(' ',O1.city, O1.STATE, O1.country) AS CurrentOfficeLocation,
	O2.officecode, concat_ws(' ',O2.city, O2.STATE, O2.country) AS NextOfficeLocation
FROM offices O1 JOIN offices O2
ON O1.officecode+1 = O2.officecode;
-- How about before the first, or next of the last number? : Notice that current office 7  & next office 1 was not displayed.
-- => Using (INNER) JOIN, if there is no matched cases, then it will not return the value. But, this will be different in LEFT/RIGHT OUTER JOIN
-- This will be different with OUTER JOIN.

# 2. LEFT/RIGHT OUTER JOIN
select O1.officecode, concat_ws(' ',O1.city, O1.STATE, O1.country) AS CurrentOfficeLocation,
	O2.officecode, concat_ws(' ',O2.city, O2.STATE, O2.country) AS NextOfficeLocation
FROM offices O1 LEFT JOIN offices O2 -- LEFT JOIN will show current office 7
ON O1.officecode+1 = O2.officecode;

select O1.officecode, concat_ws(' ',O1.city, O1.STATE, O1.country) AS CurrentOfficeLocation,
	O2.officecode, concat_ws(' ',O2.city, O2.STATE, O2.country) AS NextOfficeLocation
FROM offices O1 RIGHT JOIN offices O2 -- RIGHT JOIN will show next office 1
ON O1.officecode+1 = O2.officecode; 

SELECT
  C.CustomerName, O.officecode,
  C.City, C.Country
FROM Customers C
right JOIN offices O -- LEFT / RIGHT will give different table
ON C.City = O.City AND C.Country = O.Country;

SELECT
  IFNULL(C.CustomerName,'no customer'), 
  IFNULL(O.officecode,'no office'),
  IFNULL(C.City,O.city),  -- IFNULL() is useful in this case because if there is no matches with RIGHT JOIN, then it will present null for city and country. 
						-- However, if we use IFNULL(), then we can still see the city and country for the office code even there is no customers there. Check with right join w/o IFNULL() case.
  C.Country,O.country
FROM Customers C
right JOIN offices O -- LEFT / RIGHT will give different table
ON C.City = O.City AND C.Country = O.Country;

# 3. CROSS JOIN 
-- return all combinations of A table * B table without conditions (e.g., no ON ~~)
select O1.officecode, concat_ws(' ',O1.city, O1.STATE, O1.country) AS CurrentOfficeLocation,
	O2.officecode, concat_ws(' ',O2.city, O2.STATE, O2.country) AS NextOfficeLocation
FROM offices O1 CROSS JOIN offices O2
order by O1.officecode desc, o2.officecode asc;

