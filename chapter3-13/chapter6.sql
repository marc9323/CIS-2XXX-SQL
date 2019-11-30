Marc D. Holman
CIS 2720 SQL I : NET
10 / 2 / 2019
Chapter 6

Multiple Choice

1 c
2 c
3 d
4 a
5 c
6 b
7 b
8 a
9 a
10 b
11 b
12 g
13 c
14 c
15 a
16 e
17 b – USER_INDEXES data dictionary
18 c
19 c
20 c – simply omit public keyword


Hands On Assignment

1.)

CREATE SEQUENCE customers_customer#_seq
INCREMENT BY 1
START WITH 1021
NOCACHE NOCYCLE;

OUTPUT:  Sequence CUSTOMERS_CUSTOMER#_SEQ created.

2.)

INSERT INTO customers(customer#, lastname, firstname, zip)
VALUES(customers_customer#_seq.NEXTVAL, 'Shoulders', 'Frank', '23567');

OUTPUT:  1 row inserted.

3.)  

CREATE SEQUENCE my_first_seq
INCREMENT BY -3
START WITH 5
MINVALUE 0
MAXVALUE 5
NOCYCLE;

OUTPUT:  Sequence MY_FIRST_SEQ created.

4.)

SELECT my_first_seq.NEXTVAL
FROM DUAL;

Error on third run:
ORA-08004: sequence MY_FIRST_SEQ.NEXTVAL goes below MINVALUE and cannot be instantiated
08004. 00000 -  "sequence %s.NEXTVAL %s %sVALUE and cannot be instantiated"
*Cause:    instantiating NEXTVAL would violate one of MAX/MINVALUE
*Action:   alter the sequence so that a new value can be requested

Explanation:  The first run generates value 5, second run 2, then, since we increment by negative 3, the third run generates a value less than MINVALUE and an error is thrown.

