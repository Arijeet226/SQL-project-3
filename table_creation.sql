--CREATE ONLINE_FOOD_DEL_DATABASE

CREATE DATABASE ONLINE_FOOD_DEL;
USE ONLINE_FOOD_DEL;

--Create_tables (cust---res---menu---_order---order_det)

CREATE TABLE customers
(customer_id INT PRIMARY KEY,
customer_name VARCHAR(60),
email VARCHAR (60),
city VARCHAR (60),
signup_date DATE
);

CREATE TABLE resturant
(resturant_id INT PRIMARY KEY,
rest_name VARCHAR (60),
city VARCHAR (60),
reg_date date);

CREATE TABLE menu_item
(item_id INT PRIMARY KEY,
resturant_id INT,
item_name VARCHAR (60),
price DECIMAL (10,2),
CONSTRAINT fk_menu_rest
FOREIGN KEY (resturant_id) REFERENCES resturant(resturant_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    resturant_id INT,
    order_date DATE,
    CONSTRAINT fk_cust_order
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_rest_order
        FOREIGN KEY (resturant_id) REFERENCES resturant(resturant_id)
);

CREATE TABLE order_details
(order_detail_id INT PRIMARY KEY,
order_id INT,
item_id INT,
quantity INT,
CONSTRAINT fk_order_detil
FOREIGN KEY (order_id) REFERENCES orders (order_id),
CONSTRAINT fk_menu_detil
FOREIGN KEY (item_id) REFERENCES menu_item(item_id)
);

--Understand our food ordering system_-queries
USE online_food_del;

--Find name_and_price of_all items costing more than_300/-
SELECT item_name,price
FROM menu_item
WHERE price>300;

--List top5 cheapest fooditems
SELECT item_name,price
FROM menu_item
ORDER BY price ASC
LIMIT 5;

--List_all resturant located in_delhi
SELECT rest_name,city
FROM resturant
WHERE city='Delhi';

--Show the top 3 most expensive menu items
SELECT item_name,price
FROM menu_item
ORDER BY price DESC
LIMIT 3;

--List all_orderIDs where_quantity is greater than_2
SELECT order_id,quantity
FROM order_details
WHERE quantity >2;

--Shows all_order along_with the resturant name_from which they were placed
SELECT o.order_id,r.rest_name
FROM orders o JOIN resturant r
ON o.resturant_id=r.resturant_id;

--show customers names_and_order_dates for_order_placed in_january_2023
SELECT c.customer_name,o.order_date,o.order_id
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.order_date BETWEEN '2023-01-01' AND '2023-01-31';

--list all_customer along with_their city who placed an order_on_or_after_2023 january_1
SELECT c.customer_name,c.city,o.order_date
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.order_date >= '2023-01-01';

--show resturant names_and_orderids for_order_placed from_resturants in_mumbai
SELECT r.rest_name,r.city,o.order_id
FROM resturant r
JOIN orders o
ON r.resturant_id=o.resturant_id
WHERE r.city ='Mumbai';

--show customer who have ordered from_a_specific resturant -spice villa
SELECT c.customer_name,r.rest_name,o.order_id
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN resturant r
ON o.resturant_id=r.resturant_id
WHERE r.rest_name='Spice Villa';

--count how many orders each_customer has placed
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

--show total revenue earned from_each city
SELECT SUM(m.price*od.quantity),r.city
FROM resturant r
JOIN menu_item m
ON r.resturant_id=m.resturant_id
JOIN order_details od
ON od.item_id = m.item_id
GROUP BY r.city;

--find the total number_of times_each food item was ordered
SELECT COUNT(od.quantity)AS total_orders,m.item_name
FROM menu_item m
JOIN order_details od
ON m.item_id=od.item_id
GROUP BY m.item_name;

--Calculate average order_value_of_each_customer_city
SELECT AVG(m.price)AS average_order_value,r.city
FROM menu_item m
JOIN resturant r
ON m.resturant_id=r.resturant_id
GROUP BY r.city;

--Find how many different food items were ordered per resturant
SELECT COUNT(m.item_name),r.rest_name
FROM menu_item m
JOIN resturant r
ON m.resturant_id=r.resturant_id
GROUP BY r.rest_name;

--Find cities with_more than_5_total orders
SELECT r.city,COUNT(o.order_id) AS total_orders
FROM orders o
JOIN resturant r
ON o.resturant_id=r.resturant_id
GROUP BY r.city
HAVING COUNT(o.order_id)>5;

--Show food items that earned more than_1000/- in_total revenue
SELECT m.item_name,SUM(m.price*od.quantity) AS revenue
FROM menu_item m
JOIN order_details od
ON m.item_id=od.item_id
GROUP BY m.item_name
HAVING SUM(m.price*od.quantity)>1000;

--display menu items that were ordered more than_2 times
SELECT m.item_name,COUNT(od.quantity)AS Total_order
FROM menu_item m
JOIN order_details od
ON m.item_id=od.item_id
GROUP BY m.item_name
HAVING COUNT(od.quantity)>2;

--list customers who placed more than_3_orders
SELECT c.customer_name,o.order_id,COUNT(od.quantity)AS total_order_placed
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_details od
ON o.order_id=od.order_id
GROUP BY c.customer_name,o.order_id
HAVING COUNT(od.quantity)>3;

--Show_all menu items along_with the average price of_all items
SELECT item_name,price,(SELECT AVG(price) FROM menu_item)AS avg_price
FROM menu_item;

--Show customers who placed at_least one_order
SELECT customer_name,customer_id
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

--Show each_food item and_how much more it costs than_the average
SELECT item_name,item_id,price,(SELECT AVG(price)FROM menu_item)-price AS diff_from_avg_price
FROM menu_item;

--List food items that cost more_than the average price
SELECT item_name, price
FROM menu_item
WHERE price > (SELECT AVG(price) FROM menu_item);

--Show customers who haven’t placed any_orders (HINT: USE_“not_in” )
SELECT customer_name,customer_id
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

--find the most expensive item from_the menu
SELECT item_name, price
FROM menu_item
WHERE price = (SELECT MAX(price) FROM menu_item);

--List all_customers who ordered from_a specific_resturant which_is Pizza Hub
SELECT customer_name,customer_id
FROM customers
WHERE customer_id IN (
SELECT customer_id
FROM orders
WHERE resturant_id = (
SELECT resturant_id
FROM resturant
WHERE rest_name = 'Pizza Hub'));

--find customer who have placed more_than two_orders
SELECT customer_name, customer_id
FROM customers
WHERE customer_id IN (
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 2);

--show order_detail only_for the most recent_order
SELECT c.customer_name,c.customer_id,o.order_id,o.order_date
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
ORDER BY order_date DESC
LIMIT 1;

--Show menu item that were never_ordered
SELECT item_name,item_id
FROM menu_item
WHERE item_id NOT IN (SELECT item_id FROM order_details);

--Find resturant that have the same city as_any customer
SELECT customer_name,city
FROM customers
WHERE city IN(SELECT city FROM resturant);

--Summary queries
--Total orders per city
SELECT r.city,COUNT(o.order_id)AS total_order
FROM orders o
JOIN resturant r
ON o.resturant_id=r.resturant_id
GROUP BY city
ORDER BY total_order DESC;
/*JAIPUR,HYDRABAD,DELHI have the highest number of food orders compared to other city
--active markets
--focus-marketing strategies
--expansion strategies
--improve operations in other cities*/

--Revenue generated_each_food item
SELECT m.item_name,SUM(m.price*od.quantity) AS total_revenue
FROM menu_item m
JOIN order_details od
ON m.item_id=od.item_id
GROUP BY m.item_name
ORDER BY total_revenue DESC; 
/*insights-best performaing food items
ALOO PARATHA,FISH CURRY,HAKKA NOODLES the top 3 food item generating revenue
promote it more prominently on app
ensure consistent avalaibility and faster delivery*/

--Top_5 spending customers
SELECT c.customer_name,SUM(m.price*od.quantity) AS total_revenue
FROM menu_item m
JOIN order_details od
ON m.item_id=od.item_id
JOIN orders o
ON od.order_id=o.order_id
JOIN customers c
ON o.customer_id=c.customer_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC; 
/*MUHAMMAD PATEL, VIHAAN NAIR,VIHAAN PATEl are the customers who spends more than the rest
Get a feedback from them and get to know the reason behind their trust in this platform
list and track their favourite resturant and the food ordered by them and find the pattern and crack it's popularity
Try to implement those readings in the loss making businesses to attract customers.*/


--Resturant wise order_count
SELECT r.rest_name,COUNT(o.order_id)AS order_count
FROM orders o
JOIN resturant r
ON o.resturant_id=r.resturant_id
GROUP BY rest_name
ORDER BY order_count DESC;
/*GOLDEN GARDEN, SPICE PALACE, TASTY BISTRO are the top restrurant where number of orders are more 
to the underperformers in this list it is suggested to give discount and combo offers to get more order
and study the business approach of the top runner in this list and apply those to improve the order count
To ensure the top runner to remain in this game as toppers try to follow trendy ideas to increase the frequency of order*/

--Average order_value_by_city
SELECT r.city,AVG(m.price*od.quantity) AS total_revenue
FROM order_details od
JOIN menu_item m
ON od.item_id=m.item_id
JOIN resturant r
ON m.resturant_id=r.resturant_id
GROUP BY r.city
ORDER BY total_revenue DESC; 
/*MUMBAI,HYDRABAD,PUNE have the highest average order value by city compared to SURAT AHMEDABAD
 AS top runner have active markets ,focus-marketing strategies ,
 expansion strategies , need to improve operations in other cities*/

--Monthly order_trends
SELECT MONTH(order_date)AS month_number,MONTHNAME(order_date)AS order_month,COUNT(order_id)AS total_orders
FROM orders
GROUP BY MONTH(order_date),MONTHNAME(order_date)
ORDER BY month_number;
/*insights tracking the monthly growth in orders
peak ordering months
impacts of festivals,holidays ,weather
plan time sensitive discount or campaigns*/

--Top_3_city by_revenue
SELECT c.city,SUM(m.price*od.quantity) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_details od
ON o.order_id=od.order_id
JOIN menu_item m
ON od.item_id=m.item_id
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 3;
/*CHENNAI,PUNE,BANGALORE are the top 3*/

--number of_unique_customer by_city
SELECT city, COUNT(DISTINCT customer_id) AS number_of_customer
FROM customers
GROUP BY city
ORDER BY number_of_customer DESC;
/*AHMEDBAD, CHENNAI,KOLKATA are the top 3 with most number of customer
try to focus on the least in terms of customers like JAIPUR*/


--Most frequently ordered_times
SELECT m.item_name,SUM(od.order_id)AS total_orders
FROM menu_item m
JOIN order_details od
ON m.item_id=od.item_id
GROUP BY m.item_name
ORDER BY total_orders DESC;
/*MOMOS are the most ordered times followed by fish curry and aloo paratha*/

--resturant_with low_order count(<30)
SELECT r.rest_name,COUNT(o.order_id) AS orders_count
FROM resturant r
JOIN orders o
ON r.resturant_id=o.resturant_id
GROUP BY rest_name
HAVING orders_count < 30
ORDER BY  orders_count ASC;
/* GOLDEN DINER is the lowest among less than 30 order count criteria it has 14 order count
TOTAL 11 resturant are there in this list*/
