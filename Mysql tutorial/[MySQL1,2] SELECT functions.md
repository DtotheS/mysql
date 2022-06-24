# Section 1. SELECT BASIC
## Functions with SELECT

[comment]:#[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[//]:#[![Buildstatus](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

[//]:#test

```sql
SELECT
-- * means all columns
  CustomerID AS '아이디',
  CustomerName AS '고객명',
  City AS '도시',
  Country AS '국가'
-- 💡 Not only for the column names, but also we can call any values which are not the column name
-- e.g., CustomerName, 1, 'Hello', NULL
FROM Customers
WHERE -- add condition
  City = 'London' OR Country = 'Mexico'
ORDER BY CustomerName -- Default: ASC. (DESC: descending order)
LIMIT 0, 5; -- skip 0 rows and only get 5 rows. e.g., 10, 20: skip 10 rows and call 20 rwos from 11th.
```

