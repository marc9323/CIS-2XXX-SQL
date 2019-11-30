Marc D. Holman
CIS 2721 : SQL I – NET
CHAPTER 9 ASSIGNMENT

MULTIPLE CHOICE

1 b
2 c
3 a
4 c
5 d
6 c
7 d – c & a are both invalid
8 e
9 b
10 d
11 3 missing keyword
12 c
13 e
14 e
15 a
16 c
17 b
18 b invalid identifier
19 b
20 c










HANDS ON
2.
A – Traditional Approach:
SELECT o.order#, o.orderdate, c.lastname, c.firstname
FROM orders o, customers c
WHERE o.customer# = c.customer#
AND o.shipdate IS NULL
ORDER BY o.orderdate;

B – Using JOIN keyword:

SELECT order#, orderdate, customer#
FROM customers NATURAL JOIN orders
WHERE shipdate IS NULL;

OUTPUT:

ORDER#,"ORDERDATE","LASTNAME","FIRSTNAME"
1012,03-APR-09,"NELSON","BECCA"
1016,04-APR-09,"SMITH","LEILA"
1015,04-APR-09,"FALAH","KENNETH"
1019,05-APR-09,"MONTIASA","GREG"
1018,05-APR-09,"MORALES","BONITA"
1020,05-APR-09,"JONES","KENNETH"



















3.)

A – Traditional Approach:

SELECT c.customer#, c.firstname, c.lastname, o.order#, oi.isbn, b.category, c.state
FROM customers c, orders o, books b, orderitems oi
WHERE c.customer# = o.customer# 
AND o.order# = oi.order#
AND oi.isbn = b.isbn
AND c.state = 'FL'
AND b.category = 'COMPUTER';

B – Using JOIN keyword:

SELECT customer#, c.firstname, c.lastname, order#, isbn, b.category, c.state
FROM customers c 
JOIN orders o USING(customer#)
JOIN orderitems oi USING(order#)
JOIN books b USING(isbn)
WHERE state = 'FL'
AND category = 'COMPUTER';

OUTPUT:

CUSTOMER#,"FIRSTNAME","LASTNAME","ORDER#","ISBN","CATEGORY","STATE"
1001,"BONITA","MORALES",1003,"8843172113","COMPUTER","FL"
1001,"BONITA","MORALES",1018,"8843172113","COMPUTER","FL"
1003,"LEILA","SMITH",1006,"9959789321","COMPUTER","FL"


7.)

A – Traditional Approach:

SELECT p.gift
FROM books b, promotion p
WHERE retail BETWEEN p.minretail AND p.maxretail
AND b.title = 'SHORTEST POEMS';

B – Using Join keyword:

SELECT gift from books
JOIN promotion ON retail 
BETWEEN minretail AND maxretail
WHERE title = 'SHORTEST POEMS';

OUTPUT:

GIFT
BOOK COVER












8.)

A – Traditional Approach:

SELECT a.lname, a.fname, b.title 
FROM books b, orders o, orderitems oi, customers c, bookauthor ba, author a
WHERE c.customer# = o.customer#
AND o.order# = oi.order#
AND oi.isbn = b.isbn
AND b.isbn = ba.isbn
AND ba.authorid = a.authorid
AND c.firstname = 'BECCA'
AND c.lastname = 'NELSON';

B – Using Join keyword:

SELECT a.lname, a.fname, b.title
FROM customers c
JOIN orders o ON c.customer# = o.customer#
JOIN orderitems oi ON o.order# = oi.order#
JOIN books b ON oi.isbn = b.isbn
JOIN bookauthor ba ON b.isbn = ba.isbn
JOIN author a ON ba.authorid = a.authorid
WHERE c.firstname = 'BECCA'
AND c.lastname = 'NELSON';

OUTPUT:

LNAME,"FNAME","TITLE"				
JONES,"JANICE","REVENGE	OF	MICKEY"		
BAKER,"JACK","PAINLESS	CHILD-REARING"			
WHITE,"WILLIAM","HANDCRANKED	COMPUTERS"			
WHITE,"LISA","HANDCRANKED	COMPUTERS"			
ROBINSON,"ROBERT","PAINLESS	CHILD-REARING"			
ROBINSON,"ROBERT","BIG	BEAR	AND	LITTLE	DOVE"
FIELDS,"OSCAR","PAINLESS	CHILD-REARING"			



