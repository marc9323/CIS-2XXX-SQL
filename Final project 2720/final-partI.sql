
/*  create table customers01 */
CREATE TABLE customers01
(
  customerid VARCHAR2(5),
  firstname VARCHAR2(10) NOT NULL,
  lastname VARCHAR2(10) NOT NULL,
  city VARCHAR2(12),
  st VARCHAR2(2),
  zip VARCHAR2(5),
  CONSTRAINT customers01_customerid_pk PRIMARY KEY(customerid)
);

/* create indices for customers01 */
CREATE INDEX customers01_zip_idx
ON customers01(zip);

CREATE INDEX customer_name_idx
ON customers01 (lastname, firstname);

/*  create table products01 */
CREATE TABLE products01
(
  productid VARCHAR2(5),
  productname VARCHAR2(20) NOT NULL,
  msrp NUMBER(8,2) NOT NULL,
  category VARCHAR2(20) NOT NULL,
  CONSTRAINT products01_productid_pk PRIMARY KEY(productid)
);

/* indices for products01 */
CREATE INDEX products01_msrp_idx
ON products01(msrp);

CREATE INDEX products01_prodname_idx
ON products01(productname);

/* insert data from project_file into customers01 and products01 */
INSERT INTO customers01
SELECT DISTINCT customerid, firstname, lastname, city, state, zip
FROM project_file;

INSERT INTO products01
SELECT DISTINCT productid, productname, msrp, category
FROM project_file;

/*  set up sequences for customers01 and products01 */
CREATE SEQUENCE SEQ_CUSTOMERID
INCREMENT BY 1
START WITH 120
MAXVALUE 999  /* 3 digit id to spec. */
MINVALUE 1
CYCLE;

CREATE SEQUENCE SEQ_PRODUCTID
INCREMENT BY 1
START WITH 210
MAXVALUE 999
MINVALUE 1
CYCLE;

/*  insert 2 hypothetical records into customers01 and products01 */
INSERT INTO customers01
(customerid, firstname, lastname, city, st, zip)
VALUES
(SEQ_CUSTOMERID.NEXTVAL, 'Marc', 'Holman', 'Lombard', 'IL', '60148');

INSERT INTO customers01
(customerid, firstname, lastname, city, st, zip)
VALUES
(SEQ_CUSTOMERID.NEXTVAL, 'Ronald', 'Reagan', 'Chicago', 'IL', '53467');

INSERT INTO products01
(productid, productname, msrp, category)
VALUES(SEQ_PRODUCTID.NEXTVAL, 'Television', 499.99, 'LivingRoom');

INSERT INTO products01
(productid, productname, msrp, category)
VALUES(SEQ_PRODUCTID.NEXTVAL, 'Fax', 29.99, 'Office');

/* create table oders with initial constraints */
CREATE TABLE ORDERS01
(
orderid VARCHAR2(5) 
,saleid NUMBER (5) 
,customerid VARCHAR2(5) 
,productid VARCHAR2(5) 
,saleprice NUMBER(8,2)
,saledate DATE
,quantity INTEGER DEFAULT 1
,CONSTRAINT saleid_fk FOREIGN KEY (saleid) REFERENCES project_file(saleid)
,CONSTRAINT custid_fk FOREIGN KEY (customerid) REFERENCES customers01(customerid)
,CONSTRAINT productid_fk FOREIGN KEY (productid) REFERENCES products01(productid)
);

/*  set up composite primary key on orders01 */
ALTER TABLE orders01
ADD CONSTRAINT orders01_composite_pk PRIMARY KEY(customerid, productid, saleid);

/*  add shipdate virtual column to orders01 */
ALTER TABLE orders01
ADD shipdate DATE as (saledate + 2);

/*  insert data into orders01 table from project_file */
INSERT INTO orders01(customerid, productid, saleid, saleprice, saledate)
SELECT DISTINCT customerid, productid, saleid, saleprice, to_date(saledate, 'MM/DD/YYYY')
FROM project_file;

/*  create 5 digit sequence for orders01.orderid: seq_orderid
and for orders01.saleid: seq_saleid */
CREATE SEQUENCE SEQ_ORDERID
INCREMENT BY 1
START WITH 100
MAXVALUE 99999
MINVALUE 1
CYCLE;

CREATE SEQUENCE SEQ_SALEID
INCREMENT BY 1
START WITH 360
MAXVALUE 99999
MINVALUE 1
CYCLE;

/*  use sequence seq_orderid to populate orders01.orderid */
UPDATE orders01
SET orderid = SEQ_ORDERID.NEXTVAL;

/*  drop composite primary key constraint on orders01 and saleid fk constraint */
ALTER TABLE orders01
DROP CONSTRAINT orders01_composite_pk; 

/* drop saleid_fk constraint - project_file now out of the picture */
ALTER TABLE orders01
DROP CONSTRAINT saleid_fk;

/* add constraint to set orderid as primary key for orders01 table */
ALTER TABLE orders01
ADD CONSTRAINT orders01_orderid_pk PRIMARY KEY(orderid);

/*  Create indices for orders01 table */
CREATE INDEX orders01_saledate_idx
ON orders01(saledate);

CREATE INDEX orders01_shipdate_idx
ON orders01(shipdate);

/*  add 4 hypothetical but logical records to the orders01 table */
INSERT INTO orders01
(orderid, saleid, customerid, productid, saleprice, saledate, quantity)
VALUES(SEQ_ORDERID.NEXTVAL, SEQ_SALEID.NEXTVAL, 160, 201, 150, '06-FEB-04', 2);

INSERT INTO orders01
(orderid, saleid, customerid, productid, saleprice, saledate, quantity)
VALUES(SEQ_ORDERID.NEXTVAL, SEQ_SALEID.NEXTVAL, 161, 201, 150, '07-FEB-04', 3);

INSERT INTO orders01
(orderid, saleid, customerid, productid, saleprice, saledate, quantity)
VALUES(SEQ_ORDERID.NEXTVAL, SEQ_SALEID.NEXTVAL, 106, 202, 175, '27-JUL-19', 1);

INSERT INTO orders01
(orderid, saleid, customerid, productid, saleprice, saledate, quantity)
VALUES(SEQ_ORDERID.NEXTVAL, SEQ_SALEID.NEXTVAL, 160, 203, 250, '10-OCT-19', 3);

/* This statement will show all eisting constraints */
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION, STATUS
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('products01', 'customers01', 'orders01');

/*  commit above transactions */
commit;


/*  PART II */

-- 1
SELECT DISTINCT customerid, firstname, lastname
FROM customers01
JOIN orders01 USING(customerid)
WHERE saledate < '01-OCT-05';

--2
SELECT c.firstname, c.lastname, p.productname, o.saleprice, o.saledate
FROM customers01 c, products01 p, orders01 o
WHERE o.productid = p.productid
AND o.customerid = c.customerid
AND o.saledate > '01-OCT-05' AND o.saledate < '31-OCT-05'
ORDER BY saleprice DESC;

-- 3
SELECT c.firstname, c.lastname, o.saleprice, p.msrp, (o.saleprice - p.msrp) as Discount
FROM customers01 c, products01 p, orders01 o
WHERE o.productid = p.productid
AND o.customerid = c.customerid
AND o.saleprice <= (p.msrp + (o.saleprice - p.msrp));

-- 4
SELECT customerid "ID", COUNT(customerid) "Purchases", TO_CHAR(AVG(saleprice), 999.99) "Average Saleprice"
FROM orders01
GROUP BY customerid
HAVING COUNT(customerid) >= 3
ORDER BY "Average Saleprice" DESC;

-- 5
SELECT Distinct o.customerid, c.lastname, c.firstname, c.zip, p.category
FROM customers01 c, products01 p, orders01 o
WHERE c.customerid = o.customerid
AND p.productid = o.productid
AND p.category = 'Office'
ORDER BY dbms_random.VALUE FETCH NEXT 6 ROWS ONLY;
-- category is included in results for completeness sake

--6
SELECT st "State", COUNT(customerid) "Total Customers", SUM(saleprice) "Total Sales"
FROM orders01
JOIN customers01 USING(customerid)
GROUP BY st
ORDER BY "Total Sales" DESC;
