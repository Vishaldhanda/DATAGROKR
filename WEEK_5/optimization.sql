USE dimensional_reporting_db;
EXPLAIN SELECT * FROM fact_sales WHERE customer_id=1;
CREATE INDEX idx_sales_revenue ON fact_sales(revenue);
EXPLAIN SELECT customer_id,SUM(revenue) AS total_revenue FROM fact_sales GROUP BY customer_id;
EXPLAIN SELECT p.category,SUM(f.revenue) AS total_revenue FROM fact_sales f JOIN dim_product p ON f.product_id=p.product_id WHERE p.category='Electronics' GROUP BY p.category;
SHOW INDEX FROM fact_sales;
SELECT customer_id,SUM(revenue) AS total_revenue FROM fact_sales WHERE date_id>=20250310 GROUP BY customer_id ORDER BY total_revenue DESC;
