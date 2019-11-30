-- Marc D. Holman
-- CIS 2720 – SQL I:NET
-- Chapter 12 Homework

-- Multiple Choice

-- 1 d
-- 2 c
-- 3 c
-- 4 b
-- 5 a
-- 6 c
-- 7 a
-- 8 c
-- 9 d
-- 10 a
-- 11 a
-- 12 b
-- 13 c
-- 14 b
-- 15 b
-- 16 d
-- 17 c
-- 18 b
-- 19 b
-- 20 a


-- Hands On:

-- 1.)
SELECT title, retail
FROM books
WHERE retail < (SELECT AVG(retail) FROM books);

-- TITLE,"RETAIL"
-- BODYBUILD IN 10 MINUTES A DAY,30.95
-- REVENGE OF MICKEY,22
-- COOKING WITH MUSHROOMS,19.95
-- HANDCRANKED COMPUTERS,25
-- THE WOK WAY TO COOK,28.75
-- BIG BEAR AND LITTLE DOVE,8.95
-- HOW TO GET FASTER PIZZA,29.95
-- HOW TO MANAGE THE MANAGER,31.95
-- SHORTEST POEMS,39.95



-- 4.)
SELECT order#, (quantity * paideach) as total FROM orderitems
WHERE (quantity * paideach) > (SELECT (quantity * paideach) FROM orderitems 
WHERE order# = 1008);

-- ORDER#,"TOTAL"
-- 1001,85.45
-- 1002111.9
-- 1003,55.95
-- 1004170.9
-- 1005,39.95
-- 1006,54.5
-- 1007216.45
-- 1007,54.5
-- 1007,55.95
-- 1010,55.95
-- 1011,85.45
-- 1012,50
-- 1012,85.45
-- 1013,55.95
-- 1014,44
-- 1016,85.45
-- 1018,55.95


-- 6.)
SELECT title FROM books
WHERE category IN
(SELECT category FROM books
JOIN orderitems USING(isbn)
JOIN orders USING(order#)
WHERE customer# = 1007)
AND isbn NOT IN
(SELECT isbn FROM orders
JOIN orderitems USING(order#)
WHERE customer# = 1007);

-- TITLE
-- PAINLESS CHILD-REARING
-- HANDCRANKED COMPUTERS
-- BUILDING A CAR WITH TOOTHPICKS


-- 9.)
SELECT COUNT(DISTINCT customer#) FROM orders 
JOIN orderitems USING(order#) 
WHERE isbn IN 
(SELECT isbn FROM orderitems 
JOIN bookauthor USING(isbn)
JOIN author USING(authorid)
WHERE lname= 'AUSTIN' AND fname = 'JAMES');

