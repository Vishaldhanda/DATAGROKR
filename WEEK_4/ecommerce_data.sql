USE ecommerce_db;

INSERT INTO customers (first_name,last_name,email,phone,city,registration_date,loyalty_points) VALUES
('Vishal','Dhanda','vishal@example.com','9876543210','Bangalore','2025-01-15',120),
('Rahul','Sharma','rahul@example.com',NULL,'Delhi','2025-02-20',80),
('Aman','Verma','aman@example.com','9123456780','Mumbai','2025-03-10',200),
('Priya','Singh','priya@example.com',NULL,'Pune','2025-04-05',50),
('Neha','Patel','neha@example.com','9988776655','Bangalore','2025-05-12',150),
('Arjun','Mehta','arjun@example.com','9090909090',NULL,'2025-06-18',30),
('Sneha','Rao','sneha@example.com',NULL,'Hyderabad','2025-07-22',95),
('Karan','Joshi','karan@example.com','9000011111','Chennai','2025-08-30',60);

INSERT INTO products (product_name,category,price,stock,supplier) VALUES
('Laptop','Electronics',65000,15,'TechWorld'),
('Smartphone','Electronics',30000,25,'MobileHub'),
('Headphones','Electronics',2500,50,'SoundPro'),
('Keyboard','Accessories',1500,40,'KeyTech'),
('Mouse','Accessories',800,70,'KeyTech'),
('Monitor','Electronics',12000,20,'DisplayMax'),
('Backpack','Fashion',2200,35,'BagStore'),
('Running Shoes','Fashion',4500,30,'SportFit'),
('T-Shirt','Fashion',900,60,'WearWell'),
('Coffee Maker','Home',5500,12,'HomePlus');

INSERT INTO orders (customer_id,order_date,status,shipping_city) VALUES
(1,'2026-01-10','Delivered','Bangalore'),(2,'2026-01-12','Delivered','Delhi'),
(3,'2026-01-15','Shipped','Mumbai'),(1,'2026-02-02','Delivered','Bangalore'),
(4,'2026-02-10','Pending','Pune'),(5,'2026-02-15','Delivered','Bangalore'),
(6,'2026-03-01','Cancelled',NULL),(7,'2026-03-05','Delivered','Hyderabad'),
(3,'2026-03-10','Delivered','Mumbai'),(8,'2026-03-15','Shipped','Chennai'),
(5,'2026-03-20','Delivered','Bangalore'),(2,'2026-04-01','Pending',NULL);

INSERT INTO order_items (order_id,product_id,quantity,unit_price) VALUES
(1,1,1,65000),(1,3,2,2500),(2,2,1,30000),(2,5,2,800),
(3,6,1,12000),(3,4,1,1500),(4,7,2,2200),(4,8,1,4500),
(5,9,3,900),(6,10,1,5500),(6,5,1,800),(7,3,1,2500),
(8,8,2,4500),(8,9,2,900),(9,1,1,65000),(9,5,1,800),
(10,6,2,12000),(10,4,2,1500),(11,2,1,30000),(11,3,1,2500),(12,7,1,2200);

INSERT INTO reviews (customer_id,product_id,rating,review_text,review_date) VALUES
(1,1,5,'Excellent laptop','2026-01-20'),(2,2,4,'Good phone','2026-01-25'),
(3,6,5,'Great display','2026-02-01'),(5,8,4,'Comfortable shoes','2026-03-01'),
(7,9,3,NULL,'2026-03-10'),(3,1,5,'Very good','2026-03-20');
