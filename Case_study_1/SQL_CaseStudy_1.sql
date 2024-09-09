USE sql_casestudies_1;

-- Find out rows similar to pandas info
SELECT COUNT(*) FROM order_details;

-- return n random records. Similar to pandas sample
SELECT * FROM users
ORDER BY rand() LIMIT 5;

-- Find null values 
SELECT * FROM orders
-- WHERE rating IS NULL/ IS NOT NULL 
WHERE restaurant_rating = '';


-- ########################### Case Study ####################################
-- Number of orders placed by each customers 
SELECT t2.user_id, t2.name, COUNT(*) AS 'total_order'
FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id
GROUP BY t2.user_id, t2.name;

-- restaurant with most number of menu items 
SELECT r_name, COUNT(*) AS 'total_menu'
FROM restaurants t1
JOIN menu t2
ON t1.r_id = t2.r_id
GROUP BY r_name; 

-- number of votes and avg rating of all restaurants 
SELECT r_name, COUNT(*) AS 'count', ROUND(AVG(restaurant_rating)) AS 'avg_rating'
FROM restaurants t1
JOIN orders t2
ON t1.r_id = t2.r_id
WHERE restaurant_rating != ''
GROUP BY r_name;

-- food that is being sold at most number of restaurants 
SELECT t2.f_name, COUNT(*) AS 'count' 
FROM sql_casestudies_1.menu t1
JOIN food t2
ON t1.f_id = t2.f_id
GROUP BY t2.f_name
ORDER BY count DESC LIMIT 1;

-- find restaurant with maximum revineu in a given month
-- given month - MAY
SELECT t1.r_name, MONTHNAME(DATE(t2.date)) AS 'mnth', SUM(t2.amount*t3.price) AS 'revenue' 
FROM sql_casestudies_1.restaurants t1
JOIN orders t2
ON t1.r_id = t2.r_id
JOIN menu t3
ON t1.r_id = t3.r_id
WHERE MONTHNAME(DATE(t2.date)) = 'May'
GROUP BY t1.r_name, mnth
ORDER BY revenue DESC LIMIT 1;

-- for a particular restaurant monthly revenue
SELECT t1.r_name, MONTHNAME(DATE(t2.date)) AS 'mnth', SUM(t2.amount*t3.price) AS 'revenue' 
FROM sql_casestudies_1.restaurants t1
JOIN orders t2
ON t1.r_id = t2.r_id
JOIN menu t3
ON t1.r_id = t3.r_id
WHERE t1.r_name = 'dominos'
GROUP BY t1.r_name, mnth;

-- restaurants with sales > x
-- x = 1500
SELECT t1.r_name, SUM(t2.amount) AS 'sales' FROM sql_casestudies_1.restaurants t1
JOIN orders t2
ON t1.r_id = t2.r_id
GROUP BY t1.r_name
HAVING sales>1500;

-- oeder details of a particular customer in a given date range 
-- 'khushboo'
SELECT t1.user_id, t1.name, t2.order_id, t2.date, t2.amount FROM sql_casestudies_1.users t1
JOIN sql_casestudies_1.orders t2
ON t1.user_id = t2.user_id
WHERE t1.name = 'khushboo' AND t2.date BETWEEN '2022-05-15' AND '2022-07-15';

-- most costly restaurant (avg price/dish)
SELECT t3.r_name, ROUND(SUM(price)/Count(*)) AS 'avg_price'  FROM sql_casestudies_1.menu t1
JOIN sql_casestudies_1.food t2
ON t1.f_id = t2.f_id
JOIN sql_casestudies_1.restaurants t3
ON t1.r_id = t3.r_id
GROUP BY t3.r_name
ORDER BY avg_price DESC;

-- delivery partner compensation using formula(deliveries*100+1000*average)
SELECT t1.partner_id, t2.partner_name, (COUNT(*)*100)+1000*AVG(t1.delivery_rating) AS 'compensation'
FROM sql_casestudies_1.orders t1
JOIN sql_casestudies_1.delivery_partner t2
ON t1.partner_id = t2.partner_id
GROUP BY t1.partner_id, t2.partner_name
ORDER BY compensation DESC;

























