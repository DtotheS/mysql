# Chapter 2
# Lesson 8: Union - as a set

USE w3backup; -- New data imported
show tables;

/*
UNION : UNION of sets. That is, remove duplicates.
UNION ALL : UNION without removing the duplicates.
*/

SELECT CustomerName, city, country, 'CUSTOMER' from customers;
SELECT SupplierName, city, country, 'SUPPLIER' from suppliers;

SELECT CustomerName as Name, city, country, 'CUSTOMER' from customers
UNION
SELECT SupplierName as name, city, country, 'SUPPLIER' from suppliers -- Again, mysql do not distinguish capitalization (i.e., name = Name).
ORDER BY name;

## UNION vs. UNION ALL: 합집합
SELECT CategoryID as ID from categories
WHERE categoryID > 4 -- results: 5 6 7 8
UNION ALL -- change this to UNION ALL and see the difference
select employeeid as id from employees
where employeeid % 2 = 0; -- even numbers: 2 4 6 8

## Intersection: e.g., how to find 6 & 8 in previous case?
SELECT categoryid as ID FROM categories C, employees E
WHERE C.categoryid > 4 -- 5 6 7 8 
	AND E.employeeid % 2 = 0 -- 2 4 6 8
    AND C.categoryid = E.employeeid; -- this is critical part for intersection

## Difference of sets
SELECT categoryid as ID FROM categories
WHERE categoryid > 4 -- 5 6 7 8 
	AND categoryid NOT IN (   -- criticial part for difference of sets. substract the other set.
		SELECT employeeid FROM employees
        WHERE employeeid % 2 = 0
	);
    
## Symmetric difference: The set which contains the elements which are either in set A or in set B but not in both.
-- there are many different ways to do this.

SELECT id FROM (
	SELECT categoryid as id from categories
    where categoryid > 4
    UNION ALL
    SELECT employeeid as id from employees
    where employeeid % 2 = 0)
    AS TempTable -- Here, I define new table name as TempTable. If I did not define the name for the new table, then it cuase error. You can try.
    GROUP BY id HAVING COUNT(*) = 1; -- remove intersection elements by HAVING only COUNT(*) = 1, cause intersection elements will have count >= 2.