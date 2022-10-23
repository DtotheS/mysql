# Moving Average
SELECT 
visited_on,
SUM(amount),
-- count(visited_on)
(
    SELECT sum(t2.amount)/count(t2.amount) from customers t2
    where DATEDIFF(t1.visited_on, t2.visited_on) BETWEEN 0 and 6) as avg_amount -- DATEDIFF(interval (e.g., month), date1, date2) = date1 - date2: + means date1 is past & date2 is more present
FROM customers t1
GROUP BY visited_on;