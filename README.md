# SQL-project-3-20.7.25
SQL Mini Project Challenge Online Food Delivery App This week organized by DataPencil and Kalyani Bhatnagar ma'am special thanks to all who are associated with it for helping me out throughout this journey and letting me showcase my analytical mindset and sharpen my SQL skill which will form as building blocks of my career journey. 
DAY-1-Understanding the data, Building ER diagram based on data, In which order the table must be created ,Database creation, Table creation.
DAY-2-Understanding food ordering system-SELECT, WHERE, ORDERBY and LIMIT  
DAY-3-Exploring Relationships Between Orders, Customers, and Restaurants by INNER JOIN ,WHERE.
DAY-4-Data summarizing for performance tracking using GROUPBY and Aggregations
DAY-5-Performance Filtering Using GROUPBY,HAVING, Aggregate Filtering.
DAY-6- Mainly focuses on subquery part where I did 6 extra query for extra practice but few queries are solved with the use of subquery
DAY-7-Focuses on  summarizing queries which are relevant to get business by extracting the query result that will aid in for further visualization 
DAY-8-Focuses on the same topic as of the previous day in addition some of the important date functions
DAY-9-10- Focuses on creating the visualization of each queries result and a final report  carved out of Canva to summarize all the day's work in a single document.
# Summary queries


## Total orders per city
```sql
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
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/Total_order%20vs.%20city.png)


## Revenue generated_each_food item
```sql
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
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/Total%20revenue%20VS%20Item.png)


##Top_5 spending customers
```sql
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
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/Total%20revenue%20VS%20customers.png)


##Resturant wise order
```sql
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
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/ORDER_COUNT%20%20vs%20RESTURANT.png)


##Average order value by city
```sql
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
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/Average%20revenue%20vs.%20city.png)


##Monthly order trend
```sql
SELECT MONTH(order_date)AS month_number,MONTHNAME(order_date)AS order_month,COUNT(order_id)AS total_orders
FROM orders
GROUP BY MONTH(order_date),MONTHNAME(order_date)
ORDER BY month_number;
/*insights tracking the monthly growth in orders
peak ordering months
impacts of festivals,holidays ,weather
plan time sensitive discount or campaigns*/
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/Total_orders%20vs.%20Order_month.png)


##Top 3 city by revenue
```sql
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
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/TOTAL%20REVENUE%20TOP%203%20CITY.png)


##number of_unique_customer by_city
```sql
SELECT city, COUNT(DISTINCT customer_id) AS number_of_customer
FROM customers
GROUP BY city
ORDER BY number_of_customer DESC;
/*AHMEDBAD, CHENNAI,KOLKATA are the top 3 with most number of customer
try to focus on the least in terms of customers like JAIPUR*/
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/Number_of_customer%20vs.%20city.png)


##most frequently order items
```sql
SELECT m.item_name,SUM(od.order_id)AS total_orders
FROM menu_item m
JOIN order_details od
ON m.item_id=od.item_id
GROUP BY m.item_name
ORDER BY total_orders DESC;
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/Total%20orders%20VS%20Items.png)


##resturant withy lower order count less than 30
```sql
SELECT r.rest_name,COUNT(o.order_id) AS orders_count
FROM resturant r
JOIN orders o
ON r.resturant_id=o.resturant_id
GROUP BY rest_name
HAVING orders_count < 30
ORDER BY  orders_count ASC;
/* GOLDEN DINER is the lowest among less than 30 order count criteria it has 14 order count
TOTAL 11 resturant are there in this list*/
```
![](https://github.com/Arijeet226/SQL-project-3-20.7.2025/blob/dac1a6d26a9fac994219594a1f0be3a5bd6c5c25/visualizations/Orders_count%20vs.%20Resturant.png)
