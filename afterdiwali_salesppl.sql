/*1.  List all customers with a rating of 100.*/
SELECT * FROM customers
WHERE rating=100;
/*2.  Find all records in the Customer table with NULL values in the city column.*/
SELECT * FROM customers
WHERE city IS NULL;
/*3.  Find the largest order taken by each salesperson on each date.*/
SELECT MAX(amt),snum
FROM orders 
GROUP BY snum;
/*4.  Arrange the Orders table by descending customer number.*/
SELECT * FROM orders 
ORDER BY cnum;

SELECT * FROM orders 
ORDER BY 4;
/*5.  Find which salespeople currently have orders in the Orders table.*/
SELECT * FROM salespeople
WHERE snum IN (SELECT snum FROM orders);

SELECT * FROM salespeople s
WHERE EXISTS(SELECT 1 FROM orders o WHERE s.snum=o.snum);

SELECT DISTINCT snum FROM orders;
/*6.  List names of all customers matched with the salespeople serving them.*/
SELECT c.cname ,s.sname
FROM customers c,salespeople s
WHERE c.snum=s.snum;

SELECT a.cname,b.cname
FROM customers a,customers b
WHERE a.snum=b.snum
AND a.cnum>b.cnum;
/*7.  Find the names and numbers of all salespeople who had more than one customer.*/
SELECT snum,sname 
FROM salespeople
WHERE snum IN (SELECT snum FROM customers GROUP BY snum HAVING COUNT(*)>1);

SELECT a.snum,a.sname
FROM salespeople a, (SELECT COUNT(*) c,snum FROM customers GROUP BY snum) b
WHERE a.snum=b.snum
AND b.c>1;
/*8.  Count the orders of each of the salespeople and output the results in descending order.*/
SELECT COUNT(*), snum
FROM orders 
GROUP BY snum
ORDER BY COUNT(*) DESC;
/*9.  List the Customer table if and only if one or more of the customers 
in the Customer tables are located in San Jose.*/
SELECT * FROM customers
WHERE LOWER(city)='san jose';
/*10. Match salespeople to customers according to what city they lived in.*/
SELECT a.cname ,b.sname 
FROM customers a,salespeople b
WHERE a.city=b.city;
/*11. Find the largest order taken by each salesperson.*/
SELECT MAX(amt),snum
FROM orders
GROUP BY snum;
/*12. Find customers in San Jose who has a rating above 200.*/
SELECT * FROM customers
WHERE city='San Jose'
AND rating>200;
/*13. List the names and commissions of all salespeople in London.*/
SELECT sname,comm FROM salespeople
WHERE city='London';
/*14. List all the orders of salesperson Monika from the Orders table.*/
SELECT * FROM orders 
WHERE snum=(SELECT snum  FROM salespeople WHERE sname='Monika');
/*15. Find all customers with orders on October 3.*/
SELECT * FROM customers
WHERE cnum IN (SELECT cnum FROM orders WHERE TRUNC(odate)='03-oct-96');

SELECT TRUNC(odate) FROM  orders

SELECT * FROM customers
WHERE cnum IN(SELECT cnum FROM orders WHERE to_char(odate,'fmmonth dd')='october 3');

SELECT to_char(odate,'fmmonth dd') FROM orders;
/*16. Give the sums of the amounts from the orders table, grouped by date */
SELECT SUM(amt), TRUNC(odate)
FROM orders 
GROUP  BY TRUNC(odate);
/*17. Eliminating all those dates where the SUM was not at least 2000.00 above the MAX amount.*/
SELECT SUM(amt), TRUNC(odate)
FROM orders 
GROUP  BY TRUNC(odate)
HAVING SUM(amt)>(SELECT MAX(amt) FROM orders)+2000;
/*18. Select all orders that had amounts that were greater than at least one of the orders from October 6.*/
SELECT * FROM orders
WHERE amt>ANY(SELECT amt FROM orders WHERE TRUNC(odate)='06-oct-96');

SELECT MIN(amt) FROM orders WHERE TRUNC(odate)='06-oct-96';
/*19.Write a query that uses the EXISTS operator to extract all
salespeople who have customers with a rating of 300.*/
SELECT * FROM salespeople s
WHERE EXISTS(SELECT 1 FROM customers c WHERE s.snum=c.snum AND rating =300);
/*20. Find all pairs of customers having the same rating.*/
SELECT a.cname ,b.cname 
FROM customers a, customers b
WHERE a.rating =b.rating
AND a.cnum>b.cnum;
/*21. Find all customers with CNUM, 1000 above the SNUM of Serres.*/
SELECT * FROM customers 
WHERE cnum>(SELECT snum FROM salespeople WHERE sname='Serres')+1000;
/*22. Give the salespeople’s commissions as percentage instead of decimal numbers.*/
SELECT snum,sname,comm*100||'%' comm
FROM salespeople
/*23. Find the largest order taken by each salesperson on each date, eliminating those MAX orders,
 which are less than $3000.00 in value.*/
SELECT MAX(amt),snum,TRUNC(odate)
FROM orders
GROUP BY snum,TRUNC(odate)
HAVING max(amt)>3000;
/*24. List the largest orders on October 3, for each salesperson.*/
SELECT MAX(amt),snum,TRUNC(odate)
FROM orders
WHERE TRUNC(odate)='03-oct-96'
GROUP BY snum,TRUNC(odate);
/*25. Find all customers located in cities where Serres (SNUM 1002) has customers.*/
SELECT * FROM customers 
WHERE city= (SELECT city FROM salespeople WHERE snum=1002);

SELECT * FROM customers c
WHERE EXISTS (SELECT 1 FROM salespeople s WHERE s.city=c.city AND s.snum=1002);
/*26. Select all customers with a rating above 200.00.*/
SELECT * FROM customers
WHERE rating>200;
/*27. Count the number of salespeople currently listing orders in the Orders table.*/
SELECT COUNT(*) FROM salespeople
WHERE snum IN ( SELECT snum FROM orders);
SELECT COUNT(UNIQUE snum) FROM orders;
/*28. Write a query that produces all customers serviced by salespeople with a commission above 12%. 
Output the customer’s name and the salesperson ‘s rate of commission.*/
SELECT c.cname, s.comm
FROM customers c,salespeople s
WHERE c.snum=s.snum
AND s.comm>.12;
/*29. Find salespeople who have multiple customers.*/
SELECT COUNT(*),snum FROM customers
GROUP BY snum
HAVING COUNT(*)>1;
/*30. Find salespeople with customers located in their city.*/
SELECT * FROM salespeople s
WHERE EXISTS (SELECT 1 FROM customers c WHERE s.city=c.city AND s.snum=c.snum);
/*31. Find all salespeople whose name starts with ‘P’ and the fourth character is ‘I’.*/
SELECT * FROM salespeople
WHERE sname LIKE 'P__l%'

SELECT * FROM salespeople
WHERE SUBSTR (sname ,1,1)='P'
AND SUBSTR(sname,4,1)='l';
/*32. Write a query that uses a subquery to obtain all orders for the customer named ‘Cisneros’.
 Assume you do not know his customer number.*/
SELECT * FROM orders
WHERE cnum =(SELECT cnum FROM customers WHERE cname='Cisneros');
 
SELECT * FROM orders o
WHERE EXISTS(SELECT 1 FROM customers c WHERE c.cnum=o.cnum AND c.cname='Cisneros');
/*33. Find the largest orders for ‘Serres’ and ‘Rifkin’.*/
SELECT MAX(amt), snum FROM orders
WHERE snum IN (SELECT snum FROM salespeople WHERE sname IN ('Serres','Rifkin'))
GROUP BY snum;
/*34. Extract the Salespeople table in the following order: SNUM, SNAME, COMMISSION, CITY.*/
SELECT snum,sname,comm,city FROM salespeople
/*35. Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.*/
SELECT * FROM customers
WHERE cname BETWEEN 'A' AND 'G';


SELECT * FROM customers
WHERE regexp_like(cname,'^[A-G]');
/*36. Select all the possible combinations of customers that you can assign.*/
/*37. Select all orders that are greater than the average for October 4.*/
SELECT * FROM orders 
WHERE amt> (SELECT AVG(amt) FROM orders WHERE TRUNC(odate)='04-oct-96');
/*38. Write a select command using a correlated subquery that selects the names and numbers of all 
customers with ratings equal to the maximum for their city.*/
SELECT * FROM customers c
WHERE rating=(SELECT MAX(rating) FROM customers d WHERE c.city=d.city);
/*39. Write a query that totals the orders for each day and places the results in descending order.*/
SELECT SUM(amt),TRUNC(odate) FROM orders
GROUP BY TRUNC(odate)
ORDER BY  1 DESC;
/*40. Write a select command that produces the rating followed by the name of each customer in San Jose*/.
SELECT cname ,rating FROM customers
WHERE city='San Jose';
/*41. Find all orders with amounts smaller than any amount for a customer in San Jose.*/
SELECT * FROM orders
WHERE amt<ANY(SELECT amt FROM orders WHERE cnum IN (SELECT cnum FROM customers WHERE city='San Jose'))
ORDER BY onum;
/*42. Find all orders with above average amounts for their customers.*/
SELECT * FROM orders o
WHERE amt> (SELECT round(AVG(amt),2) FROM orders v WHERE o.cnum=v.cnum);

SELECT round(AVG(amt),2) ,cnum FROM orders GROUP BY cnum;
/*43. Write a query that selects the highest rating in each city.*/
SELECT MAX(rating), city FROM customers
GROUP BY city;
/*44. Write a query that calculates the amount of the salesperson’s commission 
on order by a customer with a rating above 100.00.*/
SELECT sum(a.comm*b.amt) ,a.snum
FROM orders b,salespeople a
WHERE b.snum=a.snum 
AND cnum IN(SELECT cnum FROM customers WHERE rating >100)
GROUP BY a.snum;

SELECT sum(a.comm*b.amt) ,a.snum
FROM orders b,salespeople a
WHERE b.snum=a.snum 
GROUP BY a.snum;


/*45. Count the customers with rating above San Jose’s average.*/
SELECT COUNT(*) FROM customers
WHERE rating>(SELECT AVG(rating) FROM customers WHERE city='San Jose');
/*46. Write a query that produces all pairs of salespeople with 
themselves as well as duplicate rows with the order reversed.*/
SELECT a.sname ,b.sname 
FROM salespeople a,salespeople b
/*47. Find all salespeople that are located in either Barcelona or London.*/
SELECT * FROM salespeople
WHERE city IN ('London','Barcelona');
/*48. Find all salespeople with only one customer.*/
SELECT COUNT(*), snum
FROM customers
GROUP BY snum
HAVING COUNT(*)=1;
/*49. Write a query that joins the Customer table to itself to find 
all pairs of customers served by a single salesperson.*/
SELECT a.cname,b.cname 
FROM customers a ,customers b
GROUP BY a.snum
HAVING COUNT(*)=1;
/*50. Write a query that   will give you all orders for more than $1000.00.*/
SELECT * FROM orders 
WHERE amt>1000;
/*51. Write a query that lists each order number followed by the name of the customer who made that order.*/
SELECT o.onum,c.cname
FROM orders o,customers c
WHERE o.cnum=c.cnum;
/*53. Write a query that selects all customers whose ratings are equal than ANY (in the SQL sense) of Serres.*/
SELECT *
  FROM CUSTOMERS
 WHERE RATING = ANY
 (SELECT RATING
          FROM CUSTOMERS
         WHERE SNUM = (SELECT SNUM FROM SALESPEOPLE WHERE SNAME = 'Serres'));
/*54. Write2 queries that will produce all orders taken on October3 or October 4.*/
SELECT * FROM orders 
WHERE TRUNC(odate) IN ('03-oct-96','04-oct-96');
/*55. Write a query that produces all pairs of orders by a given customer.
Name that customer and eliminate duplicates.*/
/*56. Find only those customers whose ratings are higher than every customer in Rome.*/
SELECT * FROM customers
WHERE rating >ALL(SELECT rating FROM customers WHERE city ='Rome');
/*57. Write a query on the customers table whose output will exclude all customers with a rating < = 100.00,
unless they are located in Rome.*/
SELECT * FROM customers 
WHERE NOT (rating <=100)
OR city= 'Rome';
/*58. Find all rows from the Customer table for which the salesperson number is 1001.*/
SELECT * FROM customers
WHERE snum=1001;
/*59. Find the total amount in Orders for each salesperson for which this total is greater than 
the amount of the largest order in the table.*/
SELECT SUM(amt),snum FROM orders 
GROUP BY snum
HAVING SUM(amt)>(SELECT MAX(amt) FROM orders);
/*60. Write a query that selects all orders that have Zeroes or NULL in the Amount field.*/
SELECT * FROM orders 
WHERE amt IS NULL
OR amt=0;
/*61. Produce all combinations of salespeople and customer names such that 
the former precedes the latter alphabetically,
and the latter has a rating of less than 200.*/
SELECT c.cname ,s.sname 
FROM customers c,salespeople s
WHERE c.cname<s.sname 
AND c.rating<200;
/*62. List all salespeople’s names and the commission they have earned.*/
SELECT s.sname,(a.total*s.comm) earned
FROM salespeople s,(SELECT snum,SUM(amt) total FROM orders GROUP BY snum) a
WHERE s.snum=a.snum;
/*63. Write a query that produces the names and cities of all customers with the same rating as Hoffman.
 Write the query using Hoffman’s CNUM rather than his rating,
 so that it would still be usable if his rating changed.*/
 SELECT cname ,city
 FROM customers c
 WHERE EXISTS (SELECT 1 FROM customers a WHERE a.cnum=c.cnum AND rating  
/*64. Find all salespeople for whom there are customers that follow them in alphabetical order.*/
/*65. Write a query that produces the names and ratings of all customers of all who have above average orders.*/
/*66. Find the sum of all purchases from the Orders table.*/
/*67. Write a select command that produces the order number, amount, and date for all rows in the Order table.*/
/*68. Count the number of not null rating fields in the Customer table including duplicates.*/
/*69. Write a query that gives the names of both the salesperson and the customer 
for each order after the order number.*/
/*70. List the commissions of all salespeople servicing customers in London.*/
/*71. Write a query using ANY or ALL that will find all salespeople who have no customers 
located in their city.*/
/*72. Write a query using the EXISTS operator that selects all salespeople 
with customers located in their cities who are not assigned to them.*/
/*73. Write a query that selects all customers serviced by Peel or Motika.*/
/*74. Count the number of salespeople registering orders for each day.
(If a salesperson has more than one order on a given day,
 he or she should be counted only once.).*/
/*75. Find all orders attributed to salespeople in London.*/
/*76. Find all orders by customers not located in the same cities as their salespeople.*/
/*77. Find all salespeople who have customers with more than one current order.*/
/*78. Write a query that extracts from the Customer table every customer assigned 
to a salesperson who currently has at least one other customer
(besides the customer being selected) with orders in the Orders table.*/
/*79. Write a query that selects all customers whose name begins with ‘C’.*/
/*80. Write a query on the Customers table that will find the highest rating in each city.
 Put the output in this form:  for the city (city) the highest rating is : (rating).*/

