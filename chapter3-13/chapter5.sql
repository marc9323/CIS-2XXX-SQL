Marc D. Holman
9 / 28 / 2019
CIS 2720 SQL I : NET
Chapter 5 Homework

Multiple Choice



1 a
2 d
3 a
4 c
5 e 
6 b
7 a
8 b
9 b
10 c
11 e – lock is released when transaction control or DDL statement is issued or the EXIT command is used
12 c
13 a
14 1
15 d
16 d
17 d
18 d – if where clause is omitted the delete command will delete all rows from a table
19 d
20 d

Hands on Exercises ( 1, 2, 4, 6 )


1.)

INSERT INTO orders(order#, customer#, orderdate)
VALUES(1021, 1009, '07-JUL-09');

OUTPUT:  1 row inserted.

2.)

UPDATE orders
SET shipzip = '33222'
WHERE order# = 1017;

OUTPUT:  1 row updated.



4.)

INSERT INTO orders(order#, customer#, orderdate)
VALUES(1022, 2000, 'August 6, 2009');

OUTPUT:  

SQL Error: ORA-01858: a non-numeric character was found where a numeric was expected
01858. 00000 -  "a non-numeric character was found where a numeric was expected"
*Cause:    The input data to be converted using a date format model was
           incorrect.  The input data did not contain a number where a number was
           required by the format model.
*Action:   Fix the input data or the date format model to make sure the
           elements match in number and type.  Then retry the operation.

EXPLANATION:

The date as presented literally in the question is not in a format SQL can read.  It expects a date for this column so when it attempts to parse ‘August 6, 2009’ it gets to the first character and immediately sees that ‘the input data did not contain a number where a number was required by the format model.’, throws an error, and goes no further.

6.)

UPDATE books
SET cost = '&cost'
WHERE isbn = '&isbn';

OUTPUT:

old:UPDATE books
SET cost = '&cost'
WHERE isbn = '&isbn'
new:UPDATE books
SET cost = '42.42'
WHERE isbn = '1059831198'

1 row updated.
