# SQL Dimensional Reporting & Analytics System

## Project Overview

This repository contains the **SQL Week 5 Intermediate + Advanced project** focused on dimensional modeling and advanced SQL analytics.

The project uses a **Star Schema** and demonstrates window functions, CTE-based Month-over-Month reporting, ROLLUP, and query optimization using EXPLAIN in MySQL.

## Technical Stack

- Database: MySQL 8.0+
- Language: SQL
- Tool: MySQL Workbench
- Version Control: Git & GitHub

## Project Objectives

- Design a Star Schema for sales analytics.
- Create fact and dimension tables.
- Perform product and customer rankings.
- Generate Month-over-Month revenue reports.
- Use CTEs for analytical queries.
- Generate subtotals and grand totals using ROLLUP.
- Analyze query execution using EXPLAIN.
- Demonstrate basic SQL optimization using indexes.

## Star Schema

The project contains one central fact table and four dimension tables:

- `fact_sales` – Sales transactions and measurable values.
- `dim_customer` – Customer information and segments.
- `dim_product` – Product and category information.
- `dim_date` – Calendar attributes.
- `dim_location` – Geographic information.

```text
                 dim_customer
                      |
dim_product ---- fact_sales ---- dim_date
                      |
                dim_location
```

## Key SQL Concepts

- `RANK()` and `DENSE_RANK()` for rankings
- `LAG()` and `LEAD()` for previous/next row analysis
- `NTILE()` for customer quartiles
- Window frames for running totals
- CTEs for structured queries
- Month-over-Month revenue analysis
- `ROLLUP` for subtotals and grand totals
- `EXPLAIN` for execution-plan analysis
- Indexes for query optimization

## Project Structure

```text
sql-week5-dimensional-report/
├── schema.sql
├── data.sql
├── dimensional_queries.sql
├── optimization.sql
├── README.md
└── .gitignore
```

### File Description

**`schema.sql`** creates the database, fact table, dimension tables, relationships, constraints, and indexes.

**`data.sql`** inserts sample customers, products, dates, locations, and sales transactions.

**`dimensional_queries.sql`** contains rankings, CTEs, MoM analysis, ROLLUP, running totals, and business reports.

**`optimization.sql`** contains EXPLAIN statements, index creation, and optimization examples.

## How to Run

Open MySQL Workbench and execute the files in this order:

```text
1. schema.sql
2. data.sql
3. dimensional_queries.sql
4. optimization.sql
```

## Learning Outcomes

This project demonstrates practical knowledge of:

- Star Schema and dimensional modeling
- Fact and dimension tables
- Advanced window functions
- CTEs
- Month-over-Month analysis
- ROLLUP
- SQL execution plans
- Indexing and basic query optimization
- Business-oriented SQL reporting

## GitHub

The SQL scripts can be uploaded directly to GitHub. The actual MySQL database does not need to be uploaded. The `.sql` files provide everything required to recreate and run the project.
