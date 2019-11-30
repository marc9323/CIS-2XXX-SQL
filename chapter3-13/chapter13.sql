-- Marc Holman
-- CIS 2720 – SQL I:NET
-- 11 / 22 / 2019
-- Chapter 13 Homework

-- Multiple Choice:

-- 1 c
-- 2 c
-- 3 b
-- 4 d
-- 5 d
-- 6 e
-- 7 a
-- 8 b
-- 9 a
-- 10 d
-- 11 d
-- 12 f
-- 13 e
-- 14 c
-- 15 d
-- 16 a
-- 17 a
-- 18 b
-- 19 d
-- 20 e


-- Hands On:

-- 1.)
CREATE VIEW contact_view AS
SELECT contact, phone FROM publisher
WITH READ ONLY;

-- Output:  View CONTACT_VIEW created

-- 2.)
CREATE VIEW contact_view AS
SELECT contact, phone FROM publisher;

-- Output:  View CONTACT_VIEW created


-- 5.)
CREATE VIEW reorderinfo AS
SELECT isbn, title, contact, phone
FROM books
JOIN publisher USING(pubid);

-- Output:  View REORDERINFO created

-- 7.)
UPDATE reorderinfo SET isbn=326745999
WHERE title='THE WOK WAY TO COOK';

-- Output:
-- 00000 - "integrity constraint (%s.%s) violated - child record found"
-- Foreign key constraint violated

-- 8.)
DELETE FROM reorderinfo
WHERE contact = 'TOMMIE SEYMOUR';

-- Output:  
-- SQL Error: ORA-02292: integrity constraint (C##HR.ORDERITEMS_ISBN_FK) violated - child record found
-- 02292. 00000 - "integrity constraint (%s.%s) violated - child record found"
-- Foreign key constraint violated.
