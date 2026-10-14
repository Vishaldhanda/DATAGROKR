-- SQL DE Pipeline - Week 6
-- PostgreSQL 15+
-- Topics: MERGE, range partitioning, COPY bulk load,
-- composite indexes, partial indexes, EXPLAIN

DROP SCHEMA IF EXISTS de_pipeline CASCADE;
CREATE SCHEMA de_pipeline;
SET search_path TO de_pipeline;

-- 1. STAGING TABLE
CREATE TABLE staging_customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    city VARCHAR(80),
    customer_segment VARCHAR(30),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO staging_customer VALUES
(1,'Aarav Sharma','aarav@example.com','Bengaluru','Premium','2026-01-10 10:00:00'),
(2,'Ananya Rao','ananya@example.com','Mumbai','Regular','2026-01-11 11:00:00'),
(3,'Rohan Mehta','rohan@example.com','Delhi','Premium','2026-01-12 12:00:00'),
(4,'Priya Nair','priya@example.com','Chennai','Regular','2026-01-13 13:00:00');

-- 2. DIMENSION TABLE + MERGE
CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    city VARCHAR(80),
    customer_segment VARCHAR(30),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO dim_customer VALUES
(1,'Aarav Sharma','aarav_old@example.com','Bengaluru','Regular','2026-01-01 09:00:00'),
(2,'Ananya Rao','ananya@example.com','Mumbai','Regular','2026-01-01 09:00:00'),
(5,'Vikram Singh','vikram@example.com','Pune','Regular','2026-01-05 09:00:00');

MERGE INTO dim_customer AS target
USING staging_customer AS source
ON target.customer_id = source.customer_id
WHEN MATCHED THEN
    UPDATE SET customer_name = source.customer_name,
               email = source.email,
               city = source.city,
               customer_segment = source.customer_segment,
               updated_at = source.updated_at
WHEN NOT MATCHED THEN
    INSERT (customer_id, customer_name, email, city, customer_segment, updated_at)
    VALUES (source.customer_id, source.customer_name, source.email, source.city,
            source.customer_segment, source.updated_at);

SELECT * FROM dim_customer ORDER BY customer_id;

-- 3. RANGE PARTITIONED FACT TABLE
CREATE TABLE fact_sales (
    sale_id BIGINT NOT NULL,
    customer_id INT NOT NULL,
    sale_date DATE NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12,2) NOT NULL CHECK (unit_price >= 0),
    revenue NUMERIC(14,2) NOT NULL CHECK (revenue >= 0),
    PRIMARY KEY (sale_id, sale_date)
) PARTITION BY RANGE (sale_date);

CREATE TABLE fact_sales_2026_q1 PARTITION OF fact_sales
FOR VALUES FROM ('2026-01-01') TO ('2026-04-01');
CREATE TABLE fact_sales_2026_q2 PARTITION OF fact_sales
FOR VALUES FROM ('2026-04-01') TO ('2026-07-01');
CREATE TABLE fact_sales_2026_q3 PARTITION OF fact_sales
FOR VALUES FROM ('2026-07-01') TO ('2026-10-01');
CREATE TABLE fact_sales_2026_q4 PARTITION OF fact_sales
FOR VALUES FROM ('2026-10-01') TO ('2027-01-01');
CREATE TABLE fact_sales_default PARTITION OF fact_sales DEFAULT;

INSERT INTO fact_sales
(sale_id,customer_id,sale_date,product_id,quantity,unit_price,revenue) VALUES
(1001,1,'2026-01-15',101,1,75000,75000),
(1002,2,'2026-02-20',102,2,45000,90000),
(1003,3,'2026-03-10',103,3,5000,15000),
(1004,4,'2026-04-18',104,1,12000,12000),
(1005,1,'2026-05-25',105,2,3500,7000),
(1006,2,'2026-06-12',106,1,8000,8000),
(1007,3,'2026-07-05',101,1,75000,75000),
(1008,4,'2026-08-22',102,1,45000,45000),
(1009,1,'2026-09-14',103,4,5000,20000),
(1010,2,'2026-10-08',104,2,12000,24000),
(1011,3,'2026-11-17',105,3,3500,10500),
(1012,4,'2026-12-20',106,2,8000,16000);

SELECT tableoid::regclass AS partition_name, COUNT(*) AS rows
FROM fact_sales GROUP BY tableoid ORDER BY partition_name;

-- 4. COPY BULK LOAD
-- psql client example; replace path with your CSV path.
-- \copy fact_sales (sale_id,customer_id,sale_date,product_id,quantity,unit_price,revenue)
-- FROM 'C:/path/to/sales.csv' WITH (FORMAT csv, HEADER true);
-- Server-side alternative:
-- COPY fact_sales (sale_id,customer_id,sale_date,product_id,quantity,unit_price,revenue)
-- FROM '/absolute/path/sales.csv' WITH (FORMAT csv, HEADER true);

-- 5. COMPOSITE INDEX
CREATE INDEX idx_sales_customer_date ON fact_sales (customer_id, sale_date);

EXPLAIN SELECT * FROM fact_sales
WHERE customer_id = 1
AND sale_date >= '2026-01-01'
AND sale_date < '2026-07-01';

-- 6. PARTIAL INDEX
CREATE INDEX idx_high_value_sales
ON fact_sales (customer_id, sale_date)
WHERE revenue >= 50000;

EXPLAIN SELECT * FROM fact_sales
WHERE customer_id = 1 AND revenue >= 50000;

CREATE INDEX idx_large_quantity_sales
ON fact_sales (sale_date, product_id)
WHERE quantity >= 2;

-- 7. REPORTS
SELECT SUM(revenue) AS total_revenue FROM fact_sales;

SELECT customer_id, SUM(revenue) AS total_revenue
FROM fact_sales GROUP BY customer_id ORDER BY total_revenue DESC;

SELECT EXTRACT(YEAR FROM sale_date) AS year,
       EXTRACT(QUARTER FROM sale_date) AS quarter,
       SUM(revenue) AS total_revenue
FROM fact_sales
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(QUARTER FROM sale_date)
ORDER BY year, quarter;

SELECT * FROM fact_sales WHERE revenue >= 50000 ORDER BY revenue DESC;

-- 8. PARTITION PRUNING
EXPLAIN SELECT SUM(revenue)
FROM fact_sales
WHERE sale_date >= '2026-04-01' AND sale_date < '2026-07-01';

-- 9. VALIDATION
SELECT customer_id, customer_name, email, city, customer_segment, updated_at
FROM dim_customer ORDER BY customer_id;

SELECT COUNT(*) AS total_sales,
       COUNT(DISTINCT customer_id) AS customers,
       SUM(quantity) AS units_sold,
       SUM(revenue) AS total_revenue,
       ROUND(AVG(revenue),2) AS average_sale_value
FROM fact_sales;
