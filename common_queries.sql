-- 1. Retrieve all customers
SELECT * FROM customer;

-- 2. Display customer names and their phone numbers
SELECT First_Name, Last_Name, Phone 
FROM customer;

-- 3. Retrieve all products with their categories
SELECT p.Product_Name, c.Category_Name 
FROM product p 
JOIN category c ON p.Category_ID = c.Category_ID;

-- 4. Find products low in stock
SELECT Product_Name, Stock 
FROM product 
WHERE Stock < 10;

-- 5. Show all feedback left by customers
SELECT f.Feedback_Text, f.Feedback_Date, c.First_Name, c.Last_Name 
FROM feedback f 
JOIN customer c ON f.Customer_ID = c.Customer_ID;

-- 6. Display the total number of orders placed by each customer
SELECT Customer_ID, COUNT(Order_ID) AS Total_Orders 
FROM `order` 
GROUP BY Customer_ID;

-- 7. Retrieve all orders with their status and shipping date
SELECT Order_ID, Order_Status, Shipping_Date 
FROM `order`;

-- 8. Display the details of all orders placed in the last 30 days
SELECT * 
FROM `order` 
WHERE Order_Date >= CURDATE() - INTERVAL 30 DAY;

-- 9. Retrieve all products with active discounts
SELECT p.Product_Name, d.Discount_Percentage 
FROM product p 
JOIN discount d ON p.Product_ID = d.Product_ID 
WHERE CURDATE() BETWEEN d.Start_Date AND d.End_Date;

-- 10. List all expired coupons
SELECT * 
FROM coupon 
WHERE Expiry_Date < CURDATE();

-- 11. Show the total revenue generated from all orders
SELECT SUM(Order_Amount) AS Total_Revenue 
FROM `order`;

-- 12. Display the average order amount
SELECT AVG(Order_Amount) AS Average_Order_Amount 
FROM `order`;

-- 13. List all products sold by a specific seller
SELECT p.Product_Name, p.Brand, p.MRP 
FROM product p 
JOIN seller s ON p.Seller_ID = s.Seller_ID
WHERE s.Seller_Name = 'Best Electronics';

-- 14. Show all customers who provided reviews for a specific product
SELECT r.Customer_ID, r.Rating, r.Description, p.Product_Name 
FROM review r 
JOIN product p ON r.Product_ID = p.Product_ID
WHERE p.Product_Name = 'Smartphone';

-- 15. Find the average rating of each product
SELECT Product_ID, AVG(Rating) AS Average_Rating 
FROM review 
GROUP BY Product_ID;

-- 16. Retrieve all customers who haven’t placed an order yet
SELECT c.Customer_ID, c.First_Name, c.Last_Name 
FROM customer c 
LEFT JOIN `order` o ON c.Customer_ID = o.Customer_ID
WHERE o.Customer_ID IS NULL;

-- 17. List all notifications sent to customers
SELECT Notification_Text, Notification_Date 
FROM notification 
WHERE User_Type = 'Customer';

-- 18. Retrieve details of all orders shipped by a specific agent
SELECT s.Shipment_ID, s.Shipment_Status, o.Order_ID, o.Order_Date 
FROM shipment s 
JOIN `order` o ON s.Order_ID = o.Order_ID
WHERE s.Agent_ID = 2;

-- 19. Find the total number of shipments handled by each delivery agent
SELECT Agent_ID, COUNT(Shipment_ID) AS Total_Shipments 
FROM shipment 
GROUP BY Agent_ID;

-- 20. Retrieve the total number of products in each category
SELECT c.Category_Name, COUNT(p.Product_ID) AS Total_Products 
FROM category c 
LEFT JOIN product p ON c.Category_ID = p.Category_ID
GROUP BY c.Category_Name;

-- 21. Find the product with the highest stock
SELECT Product_Name, Stock 
FROM product 
ORDER BY Stock DESC 
LIMIT 1;

-- 22. Show the most frequently purchased product
SELECT c.Product_ID, p.Product_Name, SUM(c.Quantity) AS Total_Purchased 
FROM cart c 
JOIN product p ON c.Product_ID = p.Product_ID
GROUP BY c.Product_ID 
ORDER BY Total_Purchased DESC 
LIMIT 1;

-- 23. List all orders along with their grand total from the cart
SELECT o.Order_ID, c.GrandTotal 
FROM `order` o 
JOIN cart c ON o.Cart_ID = c.Cart_ID;

-- 24. Retrieve the feedback provided in the last 7 days
SELECT Feedback_Text, Feedback_Date 
FROM feedback 
WHERE Feedback_Date >= CURDATE() - INTERVAL 7 DAY;

-- 25. Find the products with the highest and lowest ratings
SELECT Product_ID, MAX(Rating) AS Highest_Rating 
FROM review;

SELECT Product_ID, MIN(Rating) AS Lowest_Rating 
FROM review;

-- 26. Show the revenue generated by each product
SELECT p.Product_Name, SUM(c.Quantity * p.MRP) AS Revenue 
FROM product p 
JOIN cart c ON p.Product_ID = c.Product_ID
GROUP BY p.Product_ID;

-- 27. List the top 3 best-selling products
SELECT p.Product_Name, SUM(c.Quantity) AS Total_Sold 
FROM product p 
JOIN cart c ON p.Product_ID = c.Product_ID
GROUP BY p.Product_ID 
ORDER BY Total_Sold DESC 
LIMIT 3;

-- 28. Display all orders that have not been shipped yet
SELECT o.Order_ID, o.Order_Date, o.Order_Status 
FROM `order` o 
LEFT JOIN shipment s ON o.Order_ID = s.Order_ID
WHERE s.Shipment_ID IS NULL;

-- 29. Find the category with the most products
SELECT c.Category_Name, COUNT(p.Product_ID) AS Total_Products 
FROM category c 
JOIN product p ON c.Category_ID = p.Category_ID
GROUP BY c.Category_Name 
ORDER BY Total_Products DESC 
LIMIT 1;

-- 30. Show the average discount percentage for all products
SELECT AVG(Discount_Percentage) AS Average_Discount 
FROM discount;

-- 31. Retrieve all payments made within the current month
SELECT * 
FROM payment 
WHERE MONTH(DateOfPayment) = MONTH(CURDATE()) 
AND YEAR(DateOfPayment) = YEAR(CURDATE());

-- 32. Find the most active customer based on the number of orders placed
SELECT c.Customer_ID, c.First_Name, c.Last_Name, COUNT(o.Order_ID) AS Total_Orders 
FROM customer c 
JOIN `order` o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID 
ORDER BY Total_Orders DESC 
LIMIT 1;