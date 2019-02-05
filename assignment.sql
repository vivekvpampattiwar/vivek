--46. Write a query that produces all pairs of salespeople with themselves as well as duplicate rows with the order reversed.
SELECT a.sname ,b.sname
FROM salespeople a, salespeople b
--49. Write a query that joins the Customer table to itself to find all pairs of customers served by a single salesperson.
SELECT a.cname,a.cnum, b.cname,b.cnum
FROM customers a, customers b
WHERE a.snum= b.snum
AND a.cnum<b.cnum;

--51. Write a query that lists each order number followed by the name of the customer who made that order.
SELECT o.onum, c.cname
FROM orders o, customers c
WHERE o.cnum=c.cnum;
--52. Write 2 queries that select all salespeople (by name and number) who have customers 
--in their cities who they do not service, one using a join and one a correlated subquery. Which solution is more elegant?
SELECT a.snum,a.sname
FROM salespeople a, customers b
WHERE a.city=b.city
AND a.snum<>b.snum

SELECT a.* FROM salespeople a
WHERE city IN ( SELECT city FROM  customers b WHERE a.snum!=b.snum)

--53. Write a query that selects all customers whose ratings are equal than ANY (in the SQL sense) of Serres.
SELECT * FROM customers
WHERE rating IN (SELECT rating FROM customers WHERE snum=(SELECT snum FROM salespeople WHERE sname='Serres'));
--54. Write2 queries that will produce all orders taken on October3 or October 4.
SELECT * FROM orders 
WHERE TRUNC(odate) IN ('03-oct-1996','04-oct-1996');

SELECT * FROM orders
WHERE TRUNC(odate) BETWEEN '03-oct-1996' AND '04-oct-1996';
--55. Write a query that produces all pairs of orders by a given customer. Name that customer and eliminate duplicates.
SELECT DISTINCT b.cname
FROM orders a,customers b
WHERE a.cnum=b.cnum
--56. Find only those customers whose ratings are higher than every customer in Rome.
SELECT * FROM customers
WHERE rating>ALL (SELECT rating FROM customers WHERE city='Rome');
--57. Write a query on the customers table whose output will exclude all customers with a rating < = 100.00, unless they are located in Rome.
SELECT * FROM customers
WHERE rating<= 100 OR city='Rome';
--58. Find all rows from the Customer table for which the salesperson number is 1001.
SELECT * FROM customers 
WHERE snum=(SELECT snum FROM salespeople WHERE snum= 1001);
--59. Find the total amount in Orders for each salesperson for which this total is greater than the amount of the largest order in the table.
SELECT a.total, b.snum  
FROM (SELECT SUM(amt) total, snum total FROM orders 
GROUP BY snum) a, orders b
WHERE a.snum=b.snum
AND a.total>(SELECT MAX(amt) FROM orders)

SELECT SUM(amt) total,  snum FROM orders 
GROUP BY snum
HAVING SUM(amt) >(SELECT MAX(amt) FROM orders)
--60. Write a query that selects all orders that have Zeroes or NULL in the Amount field.
SELECT * FROM orders 
WHERE amt IS NULL
AND amt = 0;
--61. Produce all combinations of salespeople and customer names such that the former precedes the latter alphabetically, 
--and the latter has a rating of less than 200.
SELECT a.sname , b.cname , b.rating
FROM salespeople a , customers b
WHERE b.rating <200
AND a.sname < b.cname;
--62. List all salespeople’s names and the commission they have earned.
SELECT sname ,comm FROM salespeople 
--63. Write a query that produces the names and cities of all customers with the same rating as Hoffman.
-- Write the query using Hoffman’s CNUM rather than his rating, so that it would still be usable if his rating changed.
SELECT cname,city FROM customers
WHERE rating=(SELECT rating FROM customers WHERE cnum=(SELECT cnum FROM customers WHERE cname='Hoffman'));
--64. Find all salespeople for whom there are customers that follow them in alphabetical order.
--65. Write a query that produces the names and ratings of all customers of all who have above average orders.
--66. Find the sum of all purchases from the Orders table.
--67. Write a select command that produces the order number, amount, and date for all rows in the Order table.
--68. Count the number of not null rating fields in the Customer table including duplicates.
--69. Write a query that gives the names of both the salesperson and the customer for each order after the order number.
--70. List the commissions of all salespeople servicing customers in London.
71. Write a query using ANY or ALL that will find all salespeople who have no customers located in their city.
72. Write a query using the EXISTS operator that selects all salespeople with customers located in their cities who are not assigned to them.
73. Write a query that selects all customers serviced by Peel or Motika.
74. Count the number of salespeople registering orders for each day. (If a salesperson has more than one order on a given day, he or she should be counted only once.).
75. Find all orders attributed to salespeople in London.
76. Find all orders by customers not located in the same cities as their salespeople.
77. Find all salespeople who have customers with more than one current order.
78. Write a query that extracts from the Customer table every customer assigned to a salesperson who currently has at least one other customer (besides the customer being selected) with orders in the Orders table.
79. Write a query that selects all customers whose name begins with ‘C’.
80. Write a query on the Customers table that will find the highest rating in each city. Put the output in this form:  for the city (city) the highest rating is : (rating).
81. Write a query that will produce the Snum values of all salespeople with orders currently in the Orders table without any repeats.
82. Write a query that lists customers in descending order of rating. Output the rating field first, followed by the customers names and numbers.
83. Find the average commission for salespeople in London.
84. Find all orders credited to the same salesperson that services Hoffman.
85. Find all salespeople whose commission is in between 0.10 and 0.12 both inclusive.
86. Write a query that will give you the names and cities of all salespeople in London with commission above 0.10
87. What will be the output from the following query? 
SELECT * FROM ORDERS WHERE (AMT < 1000 OR NOT (ODATE = 10/03/1996 AND CNUM > 2003));
88. Write a query that selects each customer’s smallest order.
88. Write a query that selects the first customer in alphabetical order whose name begins with ‘G’.
89. Write a query that counts the number of different not NULL city values in the Customers table.
90. Find the average amount from the Orders table.
91. What would be the output from the following query?
SELECT*FROM ORDERS WHERE NOT  (Odate =10/03/1996 OR Snum>1006) AND amt. >=1500);
92. Find all customers who are not located in San Jose & whose rating is above 200.
93. Give a simpler way to write this query:
SELECT Snum, Sname, city, Comm FROM salespeople WHERE (Comm>0.12 and Comm <0.14);
94. Evaluate the following query:
SELECT * FROM orders WHERE NOT ((Odate = 10/03/1996 AND Snum>1002) OR amt>2000);

95. Which salespeople attend to customers not in the city they have been assigned to?
96. Which salespeople get commission greater than 0.11 and serving customers rated less than 250?
97. Which salespeople have been assigned to the same city but get different commission percentages?
98. Which salesperson has earned the most by way of commission?
99. Does the customer who has placed the maximum number of orders have the maximum rating?
100.  Has the customer who has spent the largest amount of money been given the highest rating?












