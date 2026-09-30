# E-Commerce Database Management & Analytics System

## Project Overview

This repository contains a **SQL-based E-Commerce Database Management and Analytics System** developed as part of the **DataGrokr Pre-Learning Program (PLP) – Week 4 Assignment**.

The project demonstrates relational database design, data integrity, SQL queries, joins, NULL handling, aggregation, subqueries, window functions, and business analytics using **MySQL**.

---

## Technical Stack

* **Database:** MySQL 8.0+
* **Language:** SQL
* **Database Tool:** MySQL Workbench
* **Version Control:** Git & GitHub

---

## Database Architecture

The project consists of the following main tables:

1. **Customers** – Stores customer information and registration details.
2. **Products** – Stores product names, categories, prices, stock, and suppliers.
3. **Orders** – Stores customer orders, dates, status, and shipping information.
4. **OrderItems** – Stores products and quantities associated with each order.
5. **Reviews** – Stores customer ratings and product reviews.

### Relationships

```text
Customers
    │
    └── Orders
          │
          └── OrderItems ─── Products
                             
Customers ─── Reviews ─── Products
```

The database uses **Primary Keys, Foreign Keys, NOT NULL, UNIQUE, DEFAULT, and CHECK constraints** to maintain data integrity.

---

## Key SQL Concepts Demonstrated

### Database & Table Management

* `CREATE DATABASE`
* `CREATE TABLE`
* `ALTER TABLE`
* Primary Keys
* Foreign Keys
* Constraints

### Data Analysis

* `SELECT`
* `WHERE`
* `ORDER BY`
* `GROUP BY`
* `HAVING`
* Aggregate functions
* `CASE WHEN`

### NULL Handling

* `IS NULL`
* `IS NOT NULL`
* `COALESCE`
* `NULLIF`

### Joins

* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* Full outer join simulation using `UNION`

### Functions

**String Functions:**

* `UPPER()`
* `LOWER()`
* `CONCAT()`
* `LENGTH()`
* `TRIM()`

**Date Functions:**

* `YEAR()`
* `MONTH()`
* `MONTHNAME()`
* `DATEDIFF()`

---

## Advanced SQL Concepts

The project also includes:

* Scalar subqueries
* Correlated subqueries
* `EXISTS`
* `NOT EXISTS`
* `RANK()`
* `DENSE_RANK()`
* `LAG()`
* `LEAD()`
* `NTILE()`
* SQL Views
* `ROLLUP`
* `UNION`

---

## Analytical Queries

The project contains **35+ SQL queries** covering:

### Customer Analysis

* Customer order counts
* Customer spending
* High-value customers
* Customers without orders
* City-wise customer analysis

### Product Analysis

* Product prices
* Category-wise products
* Top-selling products
* Product revenue
* Low-stock products
* Product ratings

### Order & Revenue Analysis

* Total orders
* Order status analysis
* Customer-wise revenue
* Product-wise revenue
* Category-wise revenue
* Average order value
* Revenue calculations

---

## Project Structure

```text
sql-week4-ecommerce-report/
│
├── ecommerce_schema.sql
├── ecommerce_data.sql
├── ecommerce_queries.sql
├── README.md
└── .gitignore
```

### File Description

**`ecommerce_schema.sql`**
Creates the database, tables, relationships, and constraints.

**`ecommerce_data.sql`**
Inserts sample customers, products, orders, order items, and reviews.

**`ecommerce_queries.sql`**
Contains 35+ SQL queries for data analysis and reporting.

**`README.md`**
Contains project documentation and execution instructions.

**`.gitignore`**
Prevents unnecessary files from being uploaded to GitHub.

---

## How to Run

Open **MySQL Workbench** and execute the files in this order:

```text
1. ecommerce_schema.sql
2. ecommerce_data.sql
3. ecommerce_queries.sql
```

The first file creates the database and tables, the second inserts sample data, and the third performs the analytical queries.

---

## GitHub

The SQL files can be uploaded directly to GitHub.

**Note:** The actual MySQL database does not need to be uploaded to GitHub. GitHub stores the `.sql` files, which can later be executed to recreate the database.

---

## Learning Outcomes

This project demonstrates practical knowledge of:

* Relational database design
* SQL and MySQL
* Database constraints
* Joins
* NULL handling
* Aggregation
* Subqueries
* Window functions
* Views
* Business data analysis
* Git and GitHub

---

