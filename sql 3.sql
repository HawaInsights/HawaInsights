SELECT * FROM Sales

-- The BETWEEN command
-- Show the sales made in december 2016

SELECT * FROM Sales
WHERE Order_date BETWEEN '2016-12-01' AND '2016-12-31'

-- The LIKE Command
-- Find the customer named claire

SELECT * FROM Customer
WHERE Customer_name LIKE 'Claire%'

SELECT * FROM Customer
WHERE Customer_name LIKE 'Pete%'

SELECT * FROM Customer
WHERE Customer_name LIKE 'Ke%'

SELECT * FROM Customer
WHERE Customer_name LIKE 'P_te%'

-- Do the 7 LIKE comments
SELECT * FROM Customer
WHERE Customer_name LIKE 'Z%'

SELECT * FROM Customer
WHERE Customer_name LIKE '%i'

SELECT * FROM Product
WHERE Sub_category LIKE '%es%'

SELECT * FROM Product
WHERE Sub_category LIKE '_a%'

SELECT * FROM Customer
WHERE Customer_name LIKE 'A_%'

SELECT * FROM Customer
WHERE City LIKE 'S__%'

SELECT * FROM Product
WHERE Sub_category LIKE 'T%s'

-- ALIAS, LIMIT, ORDER BY
-- Alias - a way of renaming our table or a column or anything

SELECT City AS Our_city, age,country
FROM Customer

-- LIMIT Keyword - When you are in a hurry and want to limit specific

SELECT * FROM Customer
limit 10;

-- ORDER BY works like ASCENDING AND DESCENDING IN EXCEL \

SELECT * FROM Sales
ORDER BY profit DESC

-- Find the top 10 Best customer's ID from the sales data

SELECT * FROM Sales
ORDER BY profit DESC
limit 10;

--Find the top 5 best performed customers by their customer using profits and come up with 
a chart in power bi

CREATE TABLE Top_5_customer AS (SELECT * FROM Sales
ORDER BY profit DESC
limit '5')

SELECT * FROM Top_5_customer
-- AGGREGATE FUNCTIONS - SUM, AVG, COUNT, MAX, MIN, DISTINT.

-- COUNT FUNCTION

SELECT Count (order_line) AS Order_line, count(order_id) AS Order_id
FROM Sales

SELECT Count (*) AS number_of_rows
FROM Sales

-- Find the toatal number of customers we have

SELECT count (customer_id) AS Number_of_customer
FROM Customer

--MINIMUM AND MAXIMUM- Find minimum quantity of goods sold and the maxmum quantity of goods sold

SELECT min(quantity) AS minimum_quantity_purchased, max(quantity) AS maximum_quantity_purchased
FROM sales

-- AVERAGE AND SUM

-- Find the average price in sales

SELECT avg(sales) AS average_sales
FROM Sales

-- Average age of customer

SELECT * FROM Customer

SELECT avg(age) AS average_customer_age
FROM Customer

-- Sum age of customer

SELECT sum(age) AS total_sum_of_age
FROM Customer

SELECT * FROM Sales

-- Find the total sum of sales made for the year

SELECT sum(sales) AS total_sum_of_sales
FROM Sales

-- Aggregate functions works for integers only

SELECT * FROM Sales

SELECT sum(profit) AS total_profit
FROM Sales

SELECT avg(sales) AS average_sales
FROM Sales

SELECT avg(quantity) AS average_quanitity
FROM Sales

SELECT customer_id, sum(sales) AS total_sales_made_by_customer
FROM Sales
GROUP BY customer_id
ORDER BY total_sales_made_by_customer DESC
limit '2'

--GROUP BY and HAVING KEYWORD
-- GROUP BY - to categorize based on the level of a particular column, or a type of categority in a colum

SELECT * FROM Customer

-- Group the total customer for the year by their region

SELECT count(customer) AS number_of_customer_in_region, count(segment) AS number_of_segment, region
FROM Customer
GROUP BY Region;

--Group by the number of sales by each customer to know the best customer

CREATE TABLE Top_5_number_of_sales AS (SELECT sum(sales) AS total_sales_by_customer,customer_id,count(customer_id)
FROM sales
GROUP BY customer_id
ORDER BY total_sales_by_customer DESC
LIMIT '5')

SELECT * FROM Top_5_number_of_sales

--HAVING is similar to WHERE(can't use where after using group by so we use having)

--Find the age of people per region that are older than the average age 

SELECT avg(age)
FROM Customer

-- our average is 44.4

SELECT count(customer_name) AS number_of_customers, region, avg(age)
FROM customer
GROUP BY Region
HAVING avg(age) > 44.4

-- CASE SYNTHAX - Case synthax helps us to append a new column that meets a certain condition

SELECT * FROM Customer

/*Reclassify the customer's age as 
-- people between the age of 0=20, classify them as young
-- people between the age of 21-40 as Adults
-- people between the age of 41-60, classify as older
-- Finally, anyone older than 61 as Aged */

-- Classify all customer into the age group. 

SELECT *,
CASE
WHEN age <=20 THEN 'Young'
WHEN age <=40 THEN 'Adult'
WHEN age <=60 THEN 'Older'
ELSE 'Aged'
END AS Age_group
FROM Customer

SELECT * FROM Sales

-- Reclassify the sales on a new column so we can find the sales that were above average 

SELECT avg(sales) AS average_sales
FROM sales

SELECT *,
CASE
WHEN sales >22.8 THEN 'YES'
ELSE 'NO'
END AS above_or_Not_above
FROM sales

/*Task 1 - Reclassify the profit,discount and quanitity on a new column so we can find out
the ones above average*/

SELECT avg(profit) AS average_profit
FROM sales

SELECT *,
CASE
WHEN profit >28.66 THEN 'YES'
ELSE 'NO'
END AS above_or_Not_above
FROM sales


SELECT avg(discount) AS average_discount
FROM sales

SELECT *,
CASE
WHEN discount >0.156 THEN 'YES'
ELSE 'NO'
END AS above_or_Not_above
FROM sales

SELECT avg(quantity) AS average_quantity
FROM sales

SELECT *,
CASE
WHEN quantity >3.79 THEN 'YES'
ELSE 'NO'
END AS above_or_Not_above
FROM sales

--JOINING TABLES -

SELECT * FROM Sales

CREATE TABLE West_Region AS (SELECT * FROM Customer
WHERE Region = 'West')

SELECT * FROM West_Region

-- Task 1 - Left join customer data with sales data 
/* from sales data, i want sales and quantity to be returned, then from customer data i want 
name and age to be returned*/

CREATE TABLE left_joined_table AS (SELECT Customer_name, age, sales, quantity
FROM Customer
LEFT JOIN
Sales
ON customer.customer_id = sales.customer_id)

SELECT * FROM left_joined_table

-- Right join customer data with west region data

SELECT WR.customer_name, WR.age,C.state
FROM west_region AS WR
RIGHT JOIN 
Customer AS C
ON WR.customer_id = C.customer_id


-- INNER JOIN.

SELECT * FROM West_Region

SELECT WR.customer_name, WR.city, S.sales
FROM West_Region AS WR
INNER JOIN
Sales AS s
ON WR.customer_id = S.customer_id


-- FULL JOIN.

SELECT WR.customer_name, WR.city, S.sales
FROM West_Region AS WR
FULL JOIN
Sales AS S
ON WR.customer_id = S.customer_id

/* full join customer data with sales data
inner join product data with sales data*/


SELECT * FROM Product

SELECT * FROM Sales

--INNER JOIN product data with sales data
SELECT * FROM Product
INNER JOIN
Sales 
ON Product.product_id = Sales.product_id

-- FULL JOIN Customer data with sales data 

SELECT * FROM Sales

SELECT * FROM Customer


SELECT *FROM Customer
FULL JOIN
Sales 
ON Customer.customer_id = Sales.customer_id













