# Chapter 2
# Lesson 6: Query & Sub Query
use classicmodels;
show tables;

## 1. Non-correlated Subquery: sub-quesry is not related with (main, outside) query.
SELECT * from products;
select * from productlines;
SELECT
	productline, textDescription,
    (SELECT productname FROM Products where productcode  = "S10_1678") # This Subquery is not related to the main query, so just call another column for this. But this kind of use of subquery is meaningless..
    #(SELECT productname FROM Products where productScale  = "1:10") # In this case, this subquery returns more than one row (return 6 rows).
																	#So it cannot give any one value for the column, because it does not define the relationship between main vs. sub queries. 
                                                                    #So, it will give error.
from productlines;


SELECT * FROM Products
where buyPrice > (
	SELECT AVG(buyPrice) FROM Products # AVG(buyPrice) = 54.394182
);

SELECT
	productline, textDescription
FROM productlines
WHERE
	productline = ( # here, replace '=' to 'IN' give the same result.
    SELECT productline FROM products
    WHERE productname = "1997 BMW F650 ST" # Motorcycles
    );

SELECT
	productline, textDescription
FROM productlines
WHERE
	productline IN (
    SELECT productline FROM products
    WHERE buyPrice > 85);


/*
~ ALL	~ for all the subquery
~ ANY	~ for any of the subquery result
*/

SELECT * FROM products
WHERE buyPrice > ALL (               # ALL: buyPrice > Max price of motorcycle. vs. ANY: buyPrice > Min price of motorcycle
	SELECT buyPrice FROM products
    WHERE productline = "motorcycles"
);

SELECT
	productline, textDescription
FROM productlines
WHERE
	productline = ANY
    (SELECT productline FROM products
    WHERE buyPrice>85);

## 2. Related Subquery - Subquery and query are related using defined name.
select * from productlines;
select * from products;
SELECT 
	productCode, productName, productline,
    (
		SELECT textDescription FROM productlines PL # this will call textdescription from PL to PR by matching the productline for each row.
        WHERE PL.productline = PR.productline # the value should be unique. if there are multiple values, then should define way to hadle the multiple values (e.g., count(), MAX(), MIN(), etc.). See below.
	) AS linename
FROM products PR;


## Multiple related subqueries
SELECT * FROM customers;
SELECT * FROM offices;

SELECT country, city,
	(
    SELECT COUNT(*) FROM customers C
    WHERE O.country = C.country
    ) AS customoersInThesameCountryOfTheOffice,
    (
    SELECT COUNT(*) from customers C
    WHERE C.country = O.country # just in case there are people who lives in the same city name but different county, used country AND city.
    AND C.city = O.city  
    ) AS customerInThesameCityOfTheOffice
FROM OFFICES O;


SELECT productline, textdescription, # do not forget comma before the ().
	(
    select max(buyprice) from products P
    where P.productline = L.productline
    ) AS MaxPriceoftheline,
    (
    select avg(buyprice) from products P
    where P.productline = L.productline
    ) AS averagepriceoftheline
from productlines L;

SELECT productcode, productline, productname, buyprice,
( -- this part is just to show the average price in another column. not necessary.
	select avg(buyprice) from products P2
    where P2.productline = P1.productline
) as AverageBuyPriceOfItsProductline
from products P1
where buyprice < ( 
	select avg(buyprice) from products P2
    where p2.productline = p1.productline
    );  # This will give samples whose buyprice is less than its productline average buyprice.
    
## EXISTS / NOT EXISTS : if Exists / if not exists
SELECT
	productline, textdescription
    ,(select max(P.buyprice) from products P
    where P.productline = L.productline
    ) as MaxPrice -- this part is needed to show the max price for each productline. not necessary.
from productlines L
where EXISTS (
	select * from products P
    where P.productline = L.productline
    AND P.buyprice > 80 # if there exists buyprice > 80 => if the max price > 80.
);

