Marc D. Holman
CIS 2720 – SQL I : NET
Chapter Four Assignment
Multiple Choice

1 b – you can create it again
2 a
3 c
4 a
5 e
6 a – NOT NULL can be created only with column level approach
7 c
8 1 max # of primary key constraints for a table is one
9 a
10 c
11 b
12 c
13 d
14 e
15 d
16 a
17 d  - query user constraints, get system designated name, and use alter table .. rename
18 c – PRIMARY KEY, UNIQUE, NOT NULL
19 a
20 d

Hands on

1.)

CREATE TABLE store_reps
(
  rep_ID NUMBER(5) PRIMARY KEY,
  last VARCHAR2(15),
  first VARCHAR2(10),
  comm CHAR(1) DEFAULT 'Y'
);

OUTPUT:  Table STORE_REPS created.




3.)

ALTER TABLE store_reps
ADD CONSTRAINT rep_comm_ck
CHECK(comm IN ('Y', 'N'));

OUTPUT:  Table STORE_REPS altered.

5.)

CREATE TABLE book_stores
(
  store_ID NUMBER(8) PRIMARY KEY,
  name Varchar2(30) UNIQUE NOT NULL,
  contact Varchar2(30),
  rep_ID Varchar2(5)
);

OUTPUT:  Table BOOK_STORES created.

8.)

CREATE TABLE rep_contacts
(
  store_ID NUMBER(5),
  name NUMBER(5),
  quarter CHAR(3),
  rep_ID NUMBER(5),
  CONSTRAINT rep_contacts_repID_storeID_quarter_pk PRIMARY KEY(rep_ID, store_ID, quarter),
  CONSTRAINT rep_contacts_repID_fk FOREIGN KEY(rep_ID) REFERENCES store_reps(rep_ID),
  CONSTRAINT rep_contacts_storedID_fk FOREIGN KEY(store_ID) REFERENCES book_stores(store_ID)
);

OUTPUT:  Table REP_CONTACTS created.
