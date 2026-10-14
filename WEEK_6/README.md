# SQL DE Pipeline – Week 6

## Project Overview

This project demonstrates an intermediate-to-advanced SQL data engineering pipeline using PostgreSQL. It focuses on **MERGE on dimension tables, range partitioning, COPY bulk loading, composite indexes, partial indexes, and EXPLAIN**.

## Technical Stack

- Database: PostgreSQL 15+
- Language: SQL
- Tools: PostgreSQL / pgAdmin / psql
- Version Control: Git & GitHub

## Concepts Demonstrated

### MERGE on Dimension Table
A staging customer table is synchronized with `dim_customer`. Existing customers are updated and new customers are inserted.

### Range Partitioning
`fact_sales` is partitioned by `sale_date` into 2026 quarterly partitions plus a default partition.

### COPY Bulk Load
The SQL file includes PostgreSQL `COPY` and psql `\\copy` examples for loading CSV data efficiently.

### Composite Index
A composite index on `(customer_id, sale_date)` supports queries filtering by both customer and date.

### Partial Index
A partial index is created for high-value transactions where `revenue >= 50000`.

### EXPLAIN
`EXPLAIN` is used to inspect query plans and demonstrate partition pruning and index-based query optimization.

## Project Structure

```text
sql-week6-de-pipeline/
├── week6_de_pipeline.sql
├── README.md
└── .gitignore
```

All SQL code is intentionally contained in **one SQL file**.

## How to Run

1. Install PostgreSQL 15 or later.
2. Open pgAdmin Query Tool or psql.
3. Connect to a database.
4. Open `week6_de_pipeline.sql`.
5. Execute the script from top to bottom.

The script creates a separate `de_pipeline` schema.

## COPY Bulk Loading

The sample project already inserts demonstration data with `INSERT`. To test bulk loading, prepare a CSV file matching the `fact_sales` columns and replace the path in the commented `COPY`/`\\copy` command.

Run `\\copy` from the psql client. For pgAdmin, use its Import/Export facility or server-side `COPY` with a server-accessible path.

## Learning Outcomes

- Dimension-table synchronization with MERGE
- ETL staging concepts
- PostgreSQL range partitioning
- Bulk loading with COPY
- Composite indexes
- Partial indexes
- Query-plan analysis with EXPLAIN
- Basic SQL data-engineering pipeline design

## Database Compatibility

This project is written for **PostgreSQL 15+**. The syntax is not intended for MySQL because the requested feature set uses PostgreSQL-specific capabilities such as `COPY` and partial indexes.
