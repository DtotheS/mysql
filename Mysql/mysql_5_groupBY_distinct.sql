# Lesson 5. Group BY conditions

/*
NULL value will not be calculated

Thses are calculated based on group.
MAX	
MIN	
COUNT  exclude NULL values
SUM	
AVG	
*/

use classicmodels;
show tables;

# 1. Group By


SELECT Country FROM Customers
GROUP BY Country;

select * from products;
SELECT productline  FROM Products
GROUP BY productline;

## Use more than 2 columns as group by conditions
SELECT 
  Country, City,
  CONCAT_WS(', ', City, Country)
FROM Customers
GROUP BY Country, City;

## group functions
-- When we use group by, always think how we can caculate/handle (e.g., count(), MIN(), MAX(), etc...) the grouped data. Otherwise, it will give error.
select * from orders;
SELECT COUNT(*), orderdate from orders GROUP BY orderdate; # Like count(), if we are using group by, then we need to use "Calculation Function (e.g., Count, Min, Max, etc...)" to handle after group by data.
SELECT *, orderdate from orders GROUP BY orderdate; # !!!! This will give error, because it did not use calculation function for *.
SELECT COUNT(*), orderdate from orders; # without group by, this gives error since there is nothing to count: only 1 element for each orderdate.
select count(*) from orders; # number of samples 


SELECT * from orderdetails;
SELECT 
	productcode,
    sum(quantityordered) as quantitySum 
from orderdetails # from -> group by -> order by. The order is also important. Otherwise, it will give error.
group by productcode# group by
order by quantitySum desc; # & sort by quantitySum
# with rollup;  with rollup cannot be used with order by.


SELECT * from products;
SELECT
	Productline,
    max(buyPrice) as MaxPrice,
    min(buyPrice) as MinPrice,
    Truncate((Max(buyPrice) + Min(buyPrice))/2,2) AS centerPrice,
    Truncate(avg(buyPrice),2) AS AveragePrice # interestingly, should not use comma(,) at the end of the last element. It will give error.
FROM products
group by productline;
	
SELECT * from customers;
SELECT 
  CONCAT_WS(', ', City, Country) AS Location,
  COUNT(Customernumber), # exclude Null. if we use count(*) it is count including NULL values.
  count(*)
FROM Customers
GROUP BY Country, City
with rollup; # sum of total values for each column. !! Cannot be used with order by

show tables;
select * from customers;
## with Rollup
SELECT
  Country, COUNT(*)
FROM customers
GROUP BY Country
WITH ROLLUP;

## HAVING: Filterling grouped data (or columns) vs. where : filterling before grouping data (or columns).
-- Thus, where comes before group by andhaving comes after group by.
SELECT country, count(*) as Count
FROM customers
GROUP BY country
# where Count >=3; this gives error
HAVING Count >=3;

select * from products;
SELECT
	Productline,
    # quantityinstock, -- This will gives an error since, data will be grouped by productline, but then sql does not know how to handle the raw quantityinstock. Thus, we need to add functions.
    sum(quantityinstock) as sumStock,
    max(buyPrice) as MaxPrice,
    min(buyPrice) as MinPrice,
    Truncate((Max(buyPrice) + Min(buyPrice))/2,2) AS centerPrice,
    Truncate(avg(buyPrice),2) AS AveragePrice # interestingly, should not use comma(,) at the end of the last element. It will give error.
FROM products
where quantityinstock >= 2000 # Again, where will be applied before group by values.
group by productline
HAVING # Multiple conditions can be used using "AND" or "OR" operators. Comma (,) cannot be used.
	sumStock > 50000 
	OR averageprice between 40 AND 60 
    AND CenterPrice < 60;

# 2. DISTINCT : (similar to set() in Python) do not calculate, but only remove the duplicates.
-- Different to GROUP BY, do not need to use calculation functions (e.g., Count(), MIN(), MAX())
-- (??? not sure this part) Different to GROUP BY, do not sort, so it is faster than group by. Order preserved based on the order of the value occured in the DISTINCT column.
-- USE after SELECT

show tables;
SELECT * from customers;
SELECT DISTINCT salesrepemployeenumber FROM customers; -- Compare with GROUP BY Query(?)
SELECT salesrepemployeenumber from customers group by salesrepemployeenumber; 

SELECT DISTINCT country, count(country) from customers; -- gives error.
SELECT count(DISTINCT country) from customers; -- this will ignore distinct
SELECT country, count(country) from customers group by country;

SELECT DISTINCT country from customers;
SELECT country from customers group by country;

SELECT DISTINCT country
from customers
order by country desc;

SELECT DISTINCT country, city -- multiple distinct conditions
from customers
order by country, city;

## use both group by & distinct
SELECT
  Country,
  COUNT(DISTINCT CITY) # calculate number of distinct !!cities!! for each country
FROM Customers
GROUP BY Country;

SELECT 
	country, 
    count(city) # calculate number of distinct !!people!! for each country.
FROM customers
GROUP BY country;

