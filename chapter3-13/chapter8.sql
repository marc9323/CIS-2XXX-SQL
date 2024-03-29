Marc D. Holman
CIS 2720 SQL I : NET
10 / 13 / 2019
Chapter 8 Homework


Multiple Choice

1 d
2 c
3 d
4 d
5 a
6 a
7 a
8 d
9 b
10 c
11 c
12 d? – ORDER BY clause not ‘ORDER’
13 c
14 e
15 d
16 c
17 e
18 d
19 a
20 e


Hands On 

3.)

SELECT title, category
FROM books
WHERE category != 'FITNESS';

OUTPUT:

TITLE,"CATEGORY"	
REVENGE OF MICKEY,"FAMILY	LIFE"
BUILDING A CAR WITH TOOTHPICKS,"CHILDREN"	
DATABASE IMPLEMENTATION,"COMPUTER"	
COOKING WITH MUSHROOMS,"COOKING"	
HOLY GRAIL OF ORACLE,"COMPUTER"	
HANDCRANKED COMPUTERS,"COMPUTER"	
E-BUSINESS THE EASY WAY,"COMPUTER"	
PAINLESS CHILD-REARING,"FAMILY	LIFE"
THE WOK WAY TO COOK,"COOKING"	
BIG BEAR AND LITTLE DOVE,"CHILDREN"	
HOW TO GET FASTER PIZZA,"SELF	HELP"
HOW TO MANAGE THE MANAGER,"BUSINESS"	
SHORTEST POEMS,"LITERATURE"	


5.)

SELECT order#, orderdate
FROM orders
WHERE orderdate <= '01-APR-09';

SELECT order#, orderdate
FROM orders
WHERE orderdate < '01-APR-09'
OR orderdate = '01-APR-09';

OUTPUT:

ORDER#,"ORDERDATE"
1000,31-MAR-09
1001,31-MAR-09
1002,31-MAR-09
1003,01-APR-09
1004,01-APR-09
1005,01-APR-09
1006,01-APR-09

6.)

SELECT lname, fname FROM author
WHERE lname LIKE '%IN%'
ORDER BY lname, fname;

OUTPUT:

LNAME,"FNAME"
AUSTIN,"JAMES"
MARTINEZ,"SHEILA"
ROBINSON,"ROBERT"
WILKINSON,"ANTHONY"




8.)

(pattern matching)
SELECT title, category
FROM books
WHERE category LIKE 'C%N'
OR category LIKE 'C%G';

(logical operator)
SELECT title, category
FROM books
WHERE category = 'CHILDREN'
OR category = 'COOKING';

(some other operator)
SELECT title, category 
FROM books
WHERE category in ('CHILDREN', 'COOKING');

OUPUT:

TITLE,"CATEGORY"
BUILDING A CAR WITH TOOTHPICKS,"CHILDREN"
COOKING WITH MUSHROOMS,"COOKING"
THE WOK WAY TO COOK,"COOKING"
BIG BEAR AND LITTLE DOVE,"CHILDREN"





