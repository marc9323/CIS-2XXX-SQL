--SOMETHING ABOUT DATA SIZE
--AS REPORTED BY A REPORT: 
--Last year, nearly 7.9 zettabytes of data were created globally
--�and by some measures, more data has been created over the last two years than all human history combined.
--ZB 1000^7
SELECT TO_CHAR(POWER(1000,7),'999,999,999,999,999,999,999,999,999')AS ZETTABYTES FROM DUAL;
--YB 1000^8
SELECT TO_CHAR(POWER(1000,8),'999,999,999,999,999,999,999,999,999')AS YOTTABYTES FROM DUAL;
--EB 1000^6
SELECT TO_CHAR(POWER(1000,6),'999,999,999,999,999,999,999,999,999')AS  EXABYTES FROM DUAL;
--PB 1000^5
SELECT TO_CHAR(POWER(1000,5),'999,999,999,999,999,999,999,999,999')AS PETABYTES FROM DUAL;
--TB
SELECT TO_CHAR(POWER(1000,4),'999,999,999,999,999,999,999,999,999')AS TERABYTES FROM DUAL;
--GB
SELECT TO_CHAR(POWER(1000,3),'999,999,999,999,999,999,999,999,999')AS GIGABYTES FROM DUAL;
--MB
SELECT TO_CHAR(POWER(1000,2),'999,999,999,999,999,999,999,999,999')AS MEGABYTES FROM DUAL;
--KB
SELECT TO_CHAR(POWER(1000,1),'999,999,999,999,999,999,999,999,999')AS KILOBYTES FROM DUAL;

--CHAPTER 03 SCRIPTS USED IN CLASS
--CREATE BASIC TABLE
DROP TABLE CONTACT; 
CREATE TABLE CONTACT
(
ID NUMBER(4,0)
,LNAME	    VARCHAR2(12)
,FNAME	    VARCHAR2(12)
,ADDRESS    VARCHAR2(25)
,CITY	    VARCHAR2(12)
,STATE	    CHAR(2)
,ZIP	    CHAR(5)
,REC_DATE   DATE
);
--COMPLETE TABLE STRUCTURE TAKES CONSTRAINTS SUCH AS PK, FK, CHECK.  WILL BE DISCUSSED IN CHAPTER 4 
--POKE SOME OF THE JLDB TABLES TO SEE THE META DATA
--DIFFERENCE BETWEEN CHAR AND VARCHAR2
--WHY VARCHAR2 INSTEAD OF VARCHAR?

--PREVENTATIVE DROP TO AVOID CONFLICT WITH TABLE OF SAME NAME
--YOU MOST LIKELY WOULD NOT BE ABLE TO ACCIDENTALLY DROP PUBLIC TABLES OR OTHER USERS' TABLES
--DBA WILL BE FIRED IF YOU CAN 
--DROP TABLE CONTACT, LOL 

--USE DESCRIBE STATEMENT TO SEE TABLE ELEMENTS
DESC CONTACT;  

--FIND CONTACT TABLE IN DICTIONARY TABLES
--CHECK SCHEMA UNDER YOUR CONNECTION TO SEE IF TABLE CONTACT IS THERE
SELECT * FROM USER_TABLES WHERE TABLE_NAME = 'CONTACT';
SELECT * FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'CONTACT';
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, NULLABLE
FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'CONTACT';

--ADD RECORDS FROM SCRATCH
--SYSDATE = NOW(), GETDATE()
INSERT INTO CONTACT 
VALUES(1101, 'JOHN','DOE', '20 APPLEWOOD LN', 'AURORA', 'IL', '60182', SYSDATE );

SELECT * FROM CONTACT;

--ADD RECORDS BY SELECTING FROM EXISTING TABLES
INSERT INTO CONTACT
SELECT CUSTOMER#, FIRSTNAME, LASTNAME, ADDRESS, CITY, STATE, ZIP, SYSDATE+1
FROM CUSTOMERS
WHERE ROWNUM <=5;

SELECT * FROM CONTACT;
--NOTE, ORACLE DOESN'T ALLOW "SELECT *, SYSDATE FROM..". GOT TO LIST COLUMNS

--CREATE TABLE BY QUERYING AN EXISTING TABLE
--QUICK REPLICATION OF A TABLE
--INHERITE COLUMN DEFINITIONS
--DOESN'T INHERITE CONSTRAINTS SUCH AS PK, FK, CHECK
DROP TABLE CONTACT2;
CREATE TABLE CONTACT2 
AS
SELECT * FROM CUSTOMERS; 

DESC CONTACT2;
SELECT * FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'CONTACT2';
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, NULLABLE
FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'CONTACT2';

--KEY CONSTRAINTS ARE NOT INHERITED
--OBSERVE CONTACT2 IN THE TABLE FOLDER
--COMPARE CONTACT2 TO THE FOLLOIWNG STATEMENT
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'CUSTOMERS';
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'CUSTOMERS';

--RENAME TABLES
RENAME CONTACT2 TO CONTACT3;
DESC CONTACT3;
RENAME CONTACT3 TO CONTACT2;

--TRUNCATE TABLES
--TRUNCATE VS DELETE
--TRUNCATE VS DROP

TRUNCATE TABLE CONTACT2;
SELECT * FROM CONTACT2;
DESC CONTACT2;

--DROP TABLES
DROP TABLE CONTACT2;
DESC CONTACT2;

--END UP IN RECYCLE BIN
--THINGS ARE NOT REALLY WIPED OUT AS YOU THINK
SELECT OBJECT_NAME, ORIGINAL_NAME
  FROM RECYCLEBIN;

--YOU CAN DROP AND PURGE AT THE SAME TIME
--FOR EXAMPLE: DROP TABLE CONTACT2 PURGE;
--BUT TRY NOT TO DO THAT JUST IN CASE YOU WANT TO STILL GIVE IT A CHANCE TO RETORE

PURGE TABLE "BIN$oXYx3hP4S+C5sRDbFwWn+g==$0";
--BUT REFRAIN FROM RUNNING THIS.  LEAVE THIS TO DBA!!!

--11g AND 12C ALLOW FLASHBACK TABLE TO RESTORE WHEN IT IS STILL IN RECYCLEBIN
FLASHBACK TABLE CONTACT2
  TO BEFORE DROP;
DESC CONTACT2;

----MANIPULATE COLUMNS
DESC CONTACT;

--ADD
--CAN ADD MORE THAN ONE COLUMN AT ONE TIME
ALTER TABLE CONTACT
ADD COUNTY CHAR(12);
--NOTE DO NOT USE "ADD COLUMN..."
--ADDED COLUMN APPEARS AS LAST COLUMN

--POPULATE THE ADDED COLUMN USING UPDATE
UPDATE CONTACT
SET COUNTY = 'DUPAGE' WHERE COUNTY IS NULL;

SELECT * FROM CONTACT;
--UPDATE AND OTHER DML SYNTAX WILL BE DISCUSSED IN LATER CHAPTERS

SELECT * FROM USER_TAB_COLUMNS 
WHERE TABLE_NAME = 'CONTACT';

--MODIFY 
--CAN MODIFY MORE THAN ONE COLUMN AT ONE TIME
ALTER TABLE CONTACT
MODIFY COUNTY VARCHAR2(25);

--NOTE DO NOT USE "MODIFY COLUMN..."
--CHANGE ONLY APPLIES TO NEW RECORDS
--CHANGE OF LENGTH HAS TO ACCOMMODATE EXISTING DATA, CAN NOT BE SHORTER
--CHALLENGING IF LARGE AMOUNT OF DATA ARE IN THE TABLE

--MODIFY
--CAN MODIFY MORE THAN ONE COLUMN AT A TIME
--ADD BRACKETS FOR MULTIPLE, 
--BRACKETS CAN ADD CLARITY FOR ONE COLUMN MODIFICATION
ALTER TABLE CONTACT
MODIFY (COUNTY VARCHAR2(25));

ALTER TABLE BOOKS2 
MODIFY (COST NUMBER(8,2), RETAIL NUMBER(8,2));

--REANME COLUMN
ALTER TABLE CONTACT
RENAME COLUMN COUNTY TO REGION;
DESC CONTACT;
--RENAME AGAIN
ALTER TABLE CONTACT
RENAME COLUMN REGION TO COUNTY;

--DROP
--CAN ONLY DROP ONE COLUMN AT A TIME
ALTER TABLE CONTACT
DROP COLUMN COUNTY;
--NOTE DO USE "DROP COLUMN ..."

SELECT * FROM CONTACT;
DESC CONTACT;
--THERE IS NO FLASHBACK TO RESTORE DROPPED COLUMN. SO BE CAREFUL!!!

--SET UNUSED
--REALLY DBA JOB

ALTER TABLE CONTACT
SET UNUSED COLUMN REC_DATE;
--INTERESTINGLY BOTH OF ABOVE ARE ALLOWED.  ORACLE IS LOOSE ON THIS
--ONCE SET UNUSED, IT IS IRREVERIBLE. IT IS SET TO BE REMOVED AT LATER TIME WHEN TRAFIIC sLOWs

DESC CONTACT;
--CHECK UNUSED COLUMNS
SELECT * FROM DICTIONARY 
WHERE TABLE_NAME LIKE '%UNU%';

SELECT * FROM USER_UNUSED_COL_TABS;
--FIND OUT IF ANY COLUMNS HAVE BEEN SET AS UNUSED

ALTER TABLE CONTACT
DROP UNUSED COLUMNS;
--DONE DROPPING.  NOBODY KNOWS EXCEPT DBA?

-----

--DEFAULT AND VIRTUAL COLUMNS
--EXAMPLE ONE
DROP TABLE XYZ;
CREATE TABLE XYZ
(
PROD_ID NUMBER(4,0)
,PROD_NAME VARCHAR2(20)
,MSRP NUMBER(8,2)
,PROMO_DISCOUNT NUMBER(4,2) DEFAULT 0.05
,SALE_PRICE AS (MSRP - MSRP * PROMO_DISCOUNT)
);

INSERT INTO XYZ (PROD_ID, PROD_NAME, MSRP, PROMO_DISCOUNT)
VALUES(1234, 'OFFICE CHAIR', 120.25, 0.15);
INSERT INTO XYZ (PROD_ID, PROD_NAME, MSRP, PROMO_DISCOUNT)
VALUES(1235, 'COMPUTER DESK', 220.25, DEFAULT);

SELECT * FROM XYZ;
TRUNCATE TABLE XYZ;

--EXAMPLAE TWO
DROP TABLE STUDENT;
CREATE TABLE STUDENT
(
STUDID NUMBER(4)
,LNAME VARCHAR2(25)
,FNAME VARCHAR2(25)
,USERNAME AS (SUBSTR(FNAME, 0, 1) || LNAME)
,EMAIL AS ((SUBSTR(FNAME, 0, 1) || LNAME)||'@COD.EDU')
,STATUSDATE DATE DEFAULT SYSDATE
);

--INSERT METHOD 1
INSERT INTO STUDENT (STUDID, LNAME, FNAME)
VALUES(2345, 'JANE', 'ATOBELLI');
--INSERT METHOD 2
INSERT INTO STUDENT 
VALUES(2345, 'JANE', 'ATOBELLI', DEFAULT, DEFAULT, DEFAULT);

SELECT STUDID, LOWER(USERNAME), LOWER(EMAIL), STATUSDATE FROM STUDENT;

--DEFAULT VALUE OF PROMOT_DISCOUNT
--VIRTUAL COLUMN IN TABLE STRUCTURE
--CHANGE OF DISCOUNT WILL BE RFLECTED IN SALE_PRICE
--BUT YOU CAN ALWAYS CALCULATE SALE PRICE IN YOUR SELECT STATEMENT

-------

--USE DUAL TO CREATE QUICK AND USEFUL TABLES
SELECT 
EMAIL
,CAST(NUM AS NUMBER(4,0)) AS TEMP_USER_ID
,STR AS TEMP_PW
,'CHANGE PW RIGHT AWAY!' AS PROMPT
,TSTAMP
FROM 
	(
  SELECT 'yourname@gmail.com' AS EMAIL, 
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
  SELECT 'yourname@gmail.com' AS EMAIL,
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
	UNION ALL
  SELECT 'yourname@gmail.com' AS EMAIL, 
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
  SELECT 'yourname@gmail.com' AS EMAIL, 
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
	SELECT 'yourname@gmail.com' AS EMAIL, 
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
  SELECT 'yourname@gmail.com' AS EMAIL, 
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
  SELECT 'yourname@gmail.com' AS EMAIL, 
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
	SELECT 'yourname@gmail.com' AS EMAIL, 
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
  SELECT 'yourname@gmail.com' AS EMAIL,
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
  SELECT 'yourname@gmail.com' AS EMAIL, 
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
  SELECT 'yourname@gmail.com' AS EMAIL, 
	DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
  UNION ALL
  SELECT 'yourname@gmail.com' AS EMAIL, 
  DBMS_RANDOM.VALUE(1000,10000) AS NUM, 
	DBMS_RANDOM.STRING('L', 10) AS STR, 
	SYSTIMESTAMP AS TSTAMP 
	FROM DUAL
) 
	a;
