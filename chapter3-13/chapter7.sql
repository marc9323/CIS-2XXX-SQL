Marc D. Holman
CIS 2720 SQL I : NET
10 / 8 / 2019
Chapter 7 Homework

Multiple Choice

1 e – ALTER USER… IDENTIFIED BY [password]
2 d
3 b
4 b
5 b
6 b
7 a
8 a
9 c
10 d
11 a
12 d
13 c
14 a
15 d
16 d
17 d – DROP ROLE receptionist;
18 d
19 d
20 d


Hands On Assignments 1, 3, 4, 5

1.)
CREATE USER c##mholman
IDENTIFIED BY oracle;

OUPUT:
User C##MHOLMAN created.

3.)

GRANT CREATE SESSION, CREATE TABLE, ALTER ANY TABLE
TO c##mholman;

OUTPUT:  Grant succeeded.

4.)

CREATE ROLE c##customerrep;
GRANT INSERT, DELETE on c##hr.orders
TO c##customerrep;
GRANT INSERT, DELETE on c##hr.orderitems
TO c##customerrep;

OUTPUT:
Role C##CUSTOMERREP created.
Grant succeeded.
Grant succeeded.

5.)

GRANT c##customerrep
TO c##mholman;

OUTPUT:
Grant succeeded.



