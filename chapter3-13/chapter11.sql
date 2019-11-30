-- Marc D. Holman
-- CIS 2721 – SQL I:NET
-- 11 / 6 / 2019
-- Chapter 11 Homework


-- Multiple Choice:

-- 1 c
-- 2 a
-- 3 d
-- 4 a
-- 5 e
-- 6 b
-- 7 d
-- 8 e
-- 9 d
-- 10 d – a would work if changed to ‘FAMILY LIFE’ instead of ‘FAMILY’
-- 11 b
-- 12 b
-- 13 b
-- 14 b
-- 15 d
-- 16 c
-- 17 c
-- 18 a
-- 19 c
-- 20 d


-- Hands On:

-- 1.)

SELECT COUNT(*) as "COOKING STOCK"
FROM books
WHERE category = 'COOKING';

-- OUTPUT:
-- COOKING STOCK
-- 2

-- 4.)

SELECT SUM(quantity * paideach) as "Total Profit to 1017"
FROM orders o JOIN orderitems oi on o.order# = oi.order#
WHERE customer# = 1017;

-- Output:

-- Total Profit to 1017
-- 166.4

-- 6.)

SELECT TO_CHAR(AVG(SUM(quantity * paideach)), '999.99') as "Average Profit"
FROM orders JOIN orderitems on orders.order# = orderitems.order#
GROUP BY orderitems.order#;

-- Output:

-- Average Profit
-- 80.38


8.)

SELECT name, category, AVG(retail) as "Average Price"
FROM books b JOIN publisher p ON b.pubid = p.pubid
WHERE category in('COMPUTER', 'CHILDREN')
GROUP BY name, category
HAVING AVG(retail) > 50;

-- Output:

-- NAME,"CATEGORY","Average	Price"
-- PUBLISH OUR WAY,"CHILDREN",59.95	
-- AMERICAN PUBLISHING,"COMPUTER",52.3	
-- PUBLISH OUR WAY,"COMPUTER",54.5	



