--94.  Evaluate the following query:

SELECT * FROM orders WHERE NOT ((trunc(Odate) =to_date( '10/03/1996','mm/dd/yyyy') AND Snum>1002) OR amt>2000);   

95.  Which salespeople attend to customers not in the city they have been assigned to?
96.  Which salespeople get commission greater than 0.11 and serving customers rated less than 250?
97.  Which salespeople have been assigned to the same city but get different commission percentages?


--SELECT * FROM salespeople s1 WHERE EXISTS
SELECT MAX(SUM(o.amt*s.comm)),o.snum FROM orders o,salespeople s WHERE o.snum=s.snum  GROUP BY o.snum 

SELECT SUM(o.amt*s.comm) commission,o.snum 
FROM orders o,salespeople s
WHERE o.snum=s.snum  
GROUP BY o.snum 
ORDER BY commission DESC

99.  Does the customer who has placed the maximum number of orders have the maximum rating?
--100.  Has the customer who has spent the largest amount of money been given the highest rating?

SELECT max(b.rating),a.cnum
FROM (SELECT MAX(amt) largest, cnum FROM orders GROUP BY cnum) a,customers b
WHERE a.cnum=b.cnum
GROUP BY a.cnum 


--42. Find all orders with above average amounts for their customers.

SELECT *
FROM orders o
WHERE amt>(SELECT avg(amt) FROM orders WHERE o.cnum=cnum GROUP BY cnum)







SELECT ROWNUM, (total*comm) earned,a.snum, b.sname FROM (SELECT SUM(amt) total, snum FROM orders
GROUP BY snum) a, salespeople b
WHERE a.snum=b.snum
AND ROWNUM<=1
ORDER BY earned DESC 
UPDATE orders
SET amt=18.69
WHERE Onum=3001
ALTER TABLE orders
MODIFY amt NUMBER(10,2)



/

SELECT * FROM salespeople s WHERE EXISTS(
SELECT SUM(o.amt*s.comm) FROM orders o,salespeople s
WHERE s.snum=o.snum
GROUP BY o.snum)


SELECT o.snum,SUM(o.amt*s.comm) FROM orders o,salespeople s
WHERE s.snum=o.snum
GROUP BY o.snum







SELECT MAX(total) FROM (SELECT SUM(amt) total, snum FROM orders
GROUP BY snum ) 

/
SELECT * FROM salespeople WHERE snum IN  (SELECT SUM(amt) FROM orders GROUP BY snum);
/
WITH results AS
(SELECT  salary, DENSE_RANK() OVER (ORDER BY salary DESC) denserank FROM employees)
SELECT salary ct 
FROM results
WHERE  results.denserank=11
AND ROWNUM=1


--15.	Find all customers with orders on October 3

SELECT * FROM customers
WHERE cnum IN(SELECT cnum FROM orders WHERE to_char(TRUNC(odate)) LIKE '03-Oct%')

SELECT * FROM orders WHERE to_char((TRUNC(odate)),'DD-MON-YYYY')='03-OCT-1996'

SELECT to_char(SYSDATE,'DD/MONTH/YYYY') FROM dual

99. Does the customer who has placed the maximum number of orders have the maximum rating?
100.  Has the customer who has spent the largest amount of money been given the highest rating?
103.  Do all salespeople have different commissions?
alespeople 
104.  Which salespeople have no orders between 10/03/1996 and 10/05/1996?
105.  How many salespersons have succeeded in getting orders?
106.  How many customers have placed orders?
107.  On which date has each salesperson booked an order of maximum value?
108.  Who is the most successful salesperson?
109.  Who is the worst customer with respect to the company?
110.  Are all customers not having placed orders greater than 200 totally been serviced by salesperson Peel or Serres?
111.  Which customers have the same rating?
112.  Find all orders greater than the average for October 4th.
--113.  Which customers have above average orders?

SELECT a.* FROM orders a
WHERE a.amt>(SELECT AVG(b.amt) FROM orders b WHERE a.cnum=b.cnum)

SELECT * FROM orders
WHERE amt>(SELECT AVG(amt) FROM orders)

--114.  List all customers with ratings above San Jose’s average.

SELECT * FROM customers
WHERE rating>(SELECT AVG(rating) FROM customers WHERE city='San Jose')

--115.  Select the total amount in orders for each salesperson for 
--------which the total is greater than the amount of the largest order in the table.
SELECT SUM(AMT),snum FROM orders 
GROUP BY snum
HAVING SUM (amt)>(SELECT MAX(amt) FROM orders)
SELECT MAX(amt) FROM orders  



--94.	Evaluate the following query:

SELECT *
  FROM ORDERS
 WHERE NOT ((TO_CHAR(ODATE, 'mm/dd/yyyy') = '10/03/1996' AND SNUM > 1002) OR
        AMT > 2000);

SELECT *
  FROM ORDERS
 WHERE AMT < 2000
   AND (TO_CHAR(ODATE, 'mm/dd/yyyy') = '10/03/1996' OR SNUM > 1002);
SELECT *
  FROM ORDERS
 WHERE NOT (TO_CHAR(ODATE, 'mm/dd/yyyy') = '10/03/1996' AND SNUM > 1002);
SELECT *
  FROM ORDERS
 WHERE (TO_CHAR(ODATE, 'mm/dd/yyyy') = '10/03/1996' OR SNUM > 1002);

SELECT TO_CHAR(SYSDATE, 'mm/dd/yyyy') FROM DUAL;

--95.	Which salespeople attend to customers not in the city they have been assigned to?

SELECT S.SNAME, C.CNAME, S.CITY, C.CITY
  FROM SALESPEOPLE S, CUSTOMERS C
 WHERE S.SNUM = C.SNUM
   AND C.CITY != S.CITY

--96.	Which salespeople get commission greater than 0.11 and serving customers rated less than 250?

SELECT *
  FROM SALESPEOPLE
 WHERE SNUM IN (SELECT SNUM FROM CUSTOMERS WHERE RATING < 250)
   AND COMM > .11

--97.	Which salespeople have been assigned to the same city but get different commission percentages?

SELECT A.SNAME, A.SNUM, B.SNAME, B.SNUM, A.COMM, B.COMM
  FROM SALESPEOPLE A, SALESPEOPLE B
 WHERE A.CITY = B.CITY
   AND A.COMM != B.COMM

--98.	Which salesperson has earned the most by way of commission?

SELECT *
  FROM (SELECT (TOTAL * COMM) EARNED,
               RANK() OVER(ORDER BY TOTAL * COMM DESC) RANKS,
               A.SNUM,
               B.SNAME
          FROM (SELECT SUM(AMT) TOTAL, SNUM FROM ORDERS GROUP BY SNUM) A,
               SALESPEOPLE B
         WHERE A.SNUM = B.SNUM)
 WHERE RANKS = 1


