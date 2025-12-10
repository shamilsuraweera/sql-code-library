# SQL Code Library

A comprehensive guide to SQL (Structured Query Language) with practical examples, tutorials, and advanced techniques. This library covers SQL fundamentals, best practices, and implementations across different database systems.

---

## Table of Contents

1. [What is SQL?](#what-is-sql)
2. [SQL Basics](#sql-basics)
3. [Major SQL Databases & Versions](#major-sql-databases--versions)
4. [SQL vs NoSQL](#sql-vs-nosql)
5. [Library Structure](#library-structure)
6. [Getting Started](#getting-started)
7. [Key SQL Concepts](#key-sql-concepts)
8. [Performance Tips](#performance-tips)
9. [Resources](#resources)

---

## What is SQL?

### Definition
**SQL (Structured Query Language)** is a standard programming language used to manage, query, and manipulate relational databases. It provides a way to store, retrieve, update, and delete data in a structured format.

### Key Characteristics
- **Declarative Language**: You specify *what* you want, not *how* to get it
- **ACID Compliance**: Most SQL databases ensure Atomicity, Consistency, Isolation, Durability
- **Standardized Syntax**: Core SQL is consistent across different databases
- **Powerful Data Manipulation**: Complex queries, joins, aggregations, and transformations
- **Scalable**: Handles from kilobytes to terabytes of data

### Why SQL?
- **Industry Standard**: Used by 90%+ of organizations for data management
- **Reliability**: ACID properties ensure data integrity
- **Security**: Built-in user authentication and permission systems
- **Performance**: Optimized query engines for fast data retrieval
- **Flexibility**: Works with structured data of any complexity
- **Interoperability**: Consistent across different databases and platforms

### Common Use Cases
- Web application backends
- Business intelligence and reporting
- Data warehousing
- Financial systems
- Healthcare information systems
- E-commerce platforms
- Content management systems
- Data analysis and science

---

## SQL Basics

### Core SQL Operations (CRUD)

#### CREATE (INSERT)
```sql
INSERT INTO users (name, email, age) 
VALUES ('John Doe', 'john@example.com', 28);
```

#### READ (SELECT)
```sql
SELECT * FROM users WHERE age > 25;
```

#### UPDATE
```sql
UPDATE users SET age = 29 WHERE id = 1;
```

#### DELETE
```sql
DELETE FROM users WHERE id = 1;
```

### Basic SQL Syntax Structure
```sql
SELECT column1, column2
FROM table_name
WHERE condition
GROUP BY column1
HAVING aggregate_condition
ORDER BY column1 ASC
LIMIT 10;
```

---

## Major SQL Databases & Versions

### 1. MySQL

#### Overview
- **Type**: Open-source relational database
- **Developer**: Originally MySQL AB, now Oracle
- **License**: GPL (free)
- **Popularity**: One of the most popular databases for web applications

#### Major Versions

| Version | Release Year | Key Features | Status |
|---------|-------------|--------------|--------|
| **5.7** | 2013 | JSON support, improved performance, native partitioning | Supported until Oct 2023 |
| **8.0** | 2018 | Window functions, CTEs, JSON enhancements, improved InnoDB, default charset UTF-8MB4 | **Current LTS** |
| **8.1-8.4** | 2023-2024 | Improved security, performance optimizations, new SQL features | Current |

#### MySQL 8.0 Highlights
```sql
-- Window Functions (NEW in 8.0)
SELECT name, salary, 
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;

-- Common Table Expressions - CTE (NEW in 8.0)
WITH department_totals AS (
  SELECT department, SUM(salary) AS total
  FROM employees
  GROUP BY department
)
SELECT * FROM department_totals;

-- JSON Support
SELECT id, JSON_EXTRACT(data, '$.name') AS name
FROM users;
```

#### MySQL Advantages
- Simple to install and use
- Great for web development
- Good performance for medium-scale applications
- Strong community support
- Wide hosting support

#### MySQL Limitations
- Not ideal for very large-scale operations compared to enterprise databases
- Limited advanced analytics features compared to PostgreSQL
- No true partitioning support (until recent versions)

---

### 2. PostgreSQL

#### Overview
- **Type**: Open-source object-relational database
- **Developer**: PostgreSQL Global Development Group
- **License**: PostgreSQL License (free)
- **Popularity**: Preferred for complex queries and data science

#### Major Versions

| Version | Release Year | Key Features | Status |
|---------|-------------|--------------|--------|
| **9.6** | 2016 | Parallel query execution, logical replication | EOL (Oct 2021) |
| **10** | 2017 | Logical replication improvements, declarative partitioning | EOL (Oct 2022) |
| **11** | 2018 | JIT compilation, stored procedures (PL/pgSQL), partitioning improvements | Supported until Oct 2023 |
| **12** | 2019 | Improved partitioning, better GENERATED columns | Supported until Oct 2024 |
| **13-16** | 2020-2024 | Performance improvements, enhanced JSON, logical replication | **Current LTS** |

#### PostgreSQL Advanced Features
```sql
-- Full-Text Search (native)
SELECT * FROM articles WHERE search_vector @@ to_tsquery('database');

-- JSON/JSONB (more powerful than MySQL)
SELECT id, data->>'name' AS name
FROM users
WHERE data @> '{"active": true}';

-- Window Functions
SELECT name, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;

-- Common Table Expressions (Recursive)
WITH RECURSIVE numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM numbers WHERE n < 100
)
SELECT * FROM numbers;

-- Advanced Data Types
CREATE TABLE geo_data (
  id SERIAL PRIMARY KEY,
  location POINT,
  polygon_area POLYGON,
  json_data JSONB
);
```

#### PostgreSQL Advantages
- **Most Advanced Open-Source DB**: Full ACID compliance, better concurrency
- **Rich Data Types**: Arrays, JSON, JSONB, geometric types, hstore, etc.
- **Powerful Query Engine**: Query planner handles complex queries efficiently
- **Extensible**: Can add custom data types, operators, and functions
- **Superior Text Search**: Built-in full-text search capabilities
- **Better for Analytics**: Window functions, CTEs, more sophisticated aggregations
- **Replication & High Availability**: Logical replication, streaming replication

#### PostgreSQL Limitations
- Slightly slower write performance compared to MySQL for simple operations
- Larger memory footprint
- Steeper learning curve for beginners

---

### 3. Microsoft SQL Server

#### Overview
- **Type**: Commercial enterprise relational database
- **Developer**: Microsoft
- **License**: Commercial (Enterprise, Standard, Developer editions)
- **Popularity**: Dominant in enterprise environments

#### Major Versions

| Version | Release Year | Key Features | Status |
|---------|-------------|--------------|--------|
| **2012** | 2012 | Column-store indexes, improved query optimization | EOL (July 2022) |
| **2014** | 2014 | In-memory OLTP, delayed durability | EOL (July 2024) |
| **2016** | 2016 | R integration, JSON support, temporal tables | Supported until Jan 2027 |
| **2019** | 2019 | Graph database features, enhanced machine learning | Supported until Jan 2029 |
| **2022** | 2022 | Azure integration, improved performance, T-SQL enhancements | **Current LTS** |

#### SQL Server Key Features
```sql
-- Temporal Tables (tracks changes over time)
CREATE TABLE employees_temporal (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  salary DECIMAL(10,2),
  ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START,
  ValidTo DATETIME2 GENERATED ALWAYS AS ROW END,
  PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
) WITH (SYSTEM_VERSIONING = ON);

-- Window Functions
SELECT name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- Graph Database
CREATE TABLE Person (ID INT PRIMARY KEY, Name VARCHAR(100));
CREATE TABLE Knows AS EDGE;

-- JSON Support
SELECT JSON_VALUE(data, '$.name') AS name
FROM users;
```

#### SQL Server Advantages
- **Enterprise-Grade**: Robust, scalable, highly available
- **Integration**: Seamless with Microsoft ecosystem (Azure, Office, .NET)
- **Security**: Advanced encryption, row-level security, transparent data encryption
- **Performance**: Excellent for OLAP and OLTP workloads
- **Advanced Features**: Temporal tables, graph databases, machine learning integration
- **Reporting**: Excellent BI tools (Power BI, Reporting Services)
- **Support**: Professional enterprise support

#### SQL Server Limitations
- **Expensive**: Licensing costs can be high
- **Windows-Centric**: Better support on Windows (though Linux support improving)
- **Complexity**: Steep learning curve for advanced features
- **Not Open Source**: Proprietary software

---

### 4. Oracle Database

#### Overview
- **Type**: Commercial enterprise relational database
- **Developer**: Oracle Corporation
- **License**: Commercial (very expensive)
- **Popularity**: Dominant in large enterprises, banking, government

#### Major Versions

| Version | Release Year | Key Features | Status |
|---------|-------------|--------------|--------|
| **11g** | 2007 | Partitioning, RAC (Real Application Clusters) | EOL (Dec 2020) |
| **12c** | 2013 | Multi-tenancy, In-memory database, JSON support | Extended until Dec 2024 |
| **18c** | 2018 | Cloud-optimized, improved performance, autonomous features | Supported |
| **19c** | 2019 | Enhanced security, better cloud integration | **Current LTS** |
| **21c** | 2021 | New SQL features, autonomous database, blockchain | Current |

#### Oracle Advanced Features
```sql
-- Window Functions
SELECT name, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;

-- Recursive CTEs
WITH org_chart AS (
  SELECT id, name, manager_id, 1 AS level
  FROM employees
  WHERE manager_id IS NULL
  UNION ALL
  SELECT e.id, e.name, e.manager_id, oc.level + 1
  FROM employees e
  INNER JOIN org_chart oc ON e.manager_id = oc.id
)
SELECT * FROM org_chart;

-- JSON Support
SELECT json_value(data, '$.name') AS name
FROM users;
```

#### Oracle Advantages
- **Most Powerful Enterprise DB**: Handles massive data (petabytes)
- **High Availability**: RAC, Data Guard, clustering
- **Security**: Advanced encryption, audit trails, VPM
- **Performance**: Optimized for large-scale operations
- **Autonomous Database**: Self-managing, patching, upgrades
- **Comprehensive Toolset**: OEM, SQL Developer, performance tuning tools

#### Oracle Limitations
- **Very Expensive**: Licensing costs can be prohibitive
- **Complex**: Steep learning curve, requires expertise
- **Overkill for Small Projects**: Too powerful for simple applications
- **Vendor Lock-in**: Difficult to migrate away from Oracle

---

### 5. SQLite

#### Overview
- **Type**: Embedded SQL database engine
- **Developer**: D. Richard Hipp
- **License**: Public Domain (free)
- **Popularity**: Most widely deployed database engine

#### Major Versions

| Version | Release Year | Key Features | Status |
|---------|-------------|--------------|--------|
| **3.0** | 2004 | Full ACID compliance, cross-platform | Stable |
| **3.8+** | 2013+ | Window functions, CTEs, JSON support | Current |
| **3.35+** | 2021+ | Improved performance, RETURNING clause | Current |

#### SQLite Features
```sql
-- Window Functions (3.25+)
SELECT name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- JSON Support (3.38+)
SELECT json_extract(data, '$.name') AS name
FROM users;
```

#### SQLite Advantages
- **Zero Configuration**: No setup, no server needed
- **Lightweight**: Single file database
- **Portable**: Works on any platform
- **Fast**: Excellent performance for single-user/small-scale
- **ACID Compliant**: Reliable transactions
- **Widely Used**: Mobile apps, IoT, embedded systems

#### SQLite Limitations
- **Not for Concurrent Access**: Limited multi-user support
- **No User Management**: No built-in authentication
- **Scale Limitations**: Not suitable for large-scale applications
- **No Remote Access**: File-based only

---

## Key Version Differences Summary

### Feature Comparison Across Major SQL Databases

| Feature | MySQL 8.0 | PostgreSQL 15+ | SQL Server 2022 | Oracle 21c | SQLite 3.35+ |
|---------|-----------|-----------------|-----------------|------------|---|
| **Window Functions** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **CTEs (WITH clause)** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Recursive CTEs** | ❌ | ✅ | ✅ | ✅ | ❌ |
| **JSON Support** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Full-Text Search** | ❌ | ✅ | ✅ | ✅ | ❌ |
| **Graph Database** | ❌ | ❌ | ✅ | ❌ | ❌ |
| **Temporal Tables** | ❌ | ❌ | ✅ | ❌ | ❌ |
| **Partitioning** | Limited | ✅ | ✅ | ✅ | ❌ |
| **Replication** | ✅ | ✅ | ✅ | ✅ | ❌ |
| **Multi-User Support** | ✅ | ✅ | ✅ | ✅ | Limited |
| **ACID Compliance** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Cost** | Free | Free | Expensive | Very Expensive | Free |

---

## SQL vs NoSQL

### Comparison Table

| Aspect | SQL (Relational) | NoSQL (Non-Relational) |
|--------|-----------------|------------------------|
| **Data Structure** | Tables with rows and columns | Documents, key-value, graphs, time-series |
| **Schema** | Fixed schema required | Flexible/dynamic schema |
| **ACID** | Strong ACID compliance | Often eventual consistency (BASE) |
| **Scaling** | Vertical (add more power) | Horizontal (add more servers) |
| **Query Language** | SQL (standardized) | Varies (MongoDB: JSON, Cassandra: CQL, etc.) |
| **Joins** | Efficient, common | Not native; requires denormalization |
| **Transactions** | Multi-row, complex | Limited or single-document |
| **Best For** | Structured, relational data | Big data, unstructured data, real-time |
| **Examples** | MySQL, PostgreSQL, Oracle, SQL Server | MongoDB, Cassandra, Redis, DynamoDB |

### When to Use SQL
- Financial systems requiring ACID compliance
- Complex relationships between entities
- Consistent, structured data
- Complex reporting and analytics
- When data integrity is critical

### When to Use NoSQL
- Massive scale, distributed systems
- Unstructured or semi-structured data
- Real-time applications requiring horizontal scaling
- High-velocity data (streaming, IoT)
- Content management with varying structures

---

## Library Structure

This code library is organized by SQL topics:

```
├── 01.CREATE.sql              -- CREATE TABLE, database creation
├── 02.INSERT_INTO.sql         -- INSERT statements, data insertion
├── 03.SELECT.sql              -- SELECT queries, retrieving data
├── 04.WHERE.sql               -- WHERE clause, filtering
├── 05.LIKE.sql                -- Pattern matching with LIKE
├── 06.GROUP_BY.sql            -- Aggregation and grouping
├── 07.ORDER_BY.sql            -- Sorting results
├── 08.HAVING.sql              -- Filtering grouped data
├── 09.LIMIT.sql               -- Limiting result sets
├── 10.AS.sql                  -- Aliases for columns and tables
├── 11.JOIN.sql                -- INNER, LEFT, RIGHT, FULL joins
├── 12.UNION.sql               -- Combining result sets
├── 13.STRING.sql              -- String functions and manipulation
├── 14.CASE.sql                -- Conditional logic (CASE statements)
├── 15.SUBQUERY.sql            -- Nested queries
├── 16.WINDOW.sql              -- Window functions (MySQL 8.0+)
├── 17.CTE.sql                 -- Common Table Expressions
├── 18.TEMPORARY_TABLE.sql     -- Temporary tables
├── 19.PROCEDURE.sql           -- Stored procedures
├── 20.TRIGGER.sql             -- Database triggers
├── 21.EVENT.sql               -- Scheduled events
├── MySQL_README.md            -- MySQL-specific guide
└── MySQL/
    ├── 01.Installing          -- MySQL installation steps
    └── 02.Create_User.sql     -- User creation and privileges
```

Each file contains:
- **Comments** explaining the concept
- **Example Queries** demonstrating the syntax
- **Use Cases** showing when to use each feature
- **Best Practices** for optimal performance

---

## Getting Started

### 1. Choose Your Database
- **For Web Development**: MySQL or PostgreSQL
- **For Learning SQL**: SQLite or MySQL
- **For Enterprise**: SQL Server, Oracle, or PostgreSQL
- **For Analytics**: PostgreSQL or Snowflake

### 2. Install MySQL (Recommended for Learning)
See [MySQL_README.md](./MySQL_README.md) for installation and setup instructions.

### 3. Learn SQL Fundamentals
Start with these files in order:
1. `01.CREATE.sql` — Create tables and databases
2. `02.INSERT_INTO.sql` — Insert data
3. `03.SELECT.sql` — Query data
4. `04.WHERE.sql` — Filter results
5. `05.LIKE.sql` — Pattern matching
6. `06.GROUP_BY.sql` — Aggregation

### 4. Practice with Examples
- Run each query example in your SQL client
- Modify queries to experiment
- Create your own test data
- Compare results to understand behavior

### 5. Learn Advanced Topics
- `11.JOIN.sql` — Connect multiple tables
- `15.SUBQUERY.sql` — Nested queries
- `16.WINDOW.sql` — Advanced analytics
- `17.CTE.sql` — Complex query structures

---

## Key SQL Concepts

### 1. **Normalization**
Organizing data to reduce redundancy and improve data integrity.

### 2. **Indexing**
Creating indexes on frequently queried columns for faster retrieval.

### 3. **Transactions**
ACID-compliant operations ensuring data consistency:
```sql
BEGIN TRANSACTION;
  UPDATE accounts SET balance = balance - 100 WHERE id = 1;
  UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;  -- or ROLLBACK;
```

### 4. **Joins**
Combining data from multiple tables:
- **INNER JOIN**: Only matching rows
- **LEFT JOIN**: All rows from left table
- **RIGHT JOIN**: All rows from right table
- **FULL OUTER JOIN**: All rows from both tables

### 5. **Aggregation**
Summarizing data with functions like SUM, AVG, COUNT, MIN, MAX:
```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;
```

### 6. **Subqueries**
Nested queries for complex filtering:
```sql
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

### 7. **Window Functions** (MySQL 8.0+, PostgreSQL, SQL Server)
Advanced analytical functions without collapsing rows:
```sql
SELECT name, salary,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;
```

### 8. **Common Table Expressions (CTEs)**
Named temporary result sets:
```sql
WITH high_earners AS (
  SELECT * FROM employees WHERE salary > 100000
)
SELECT * FROM high_earners;
```

---

## Performance Tips

### 1. **Use Indexes Wisely**
```sql
CREATE INDEX idx_email ON users(email);
```

### 2. **Avoid SELECT ***
```sql
-- Good
SELECT id, name, email FROM users;

-- Avoid
SELECT * FROM users;
```

### 3. **Use LIMIT for Large Result Sets**
```sql
SELECT * FROM users LIMIT 100;
```

### 4. **Optimize Joins**
- Join on indexed columns
- Join small tables first (in some databases)
- Avoid cartesian products

### 5. **Use Appropriate Data Types**
- INT instead of VARCHAR for numeric IDs
- DECIMAL for money (avoid FLOAT)
- DATE/TIMESTAMP for temporal data

### 6. **Regular Maintenance**
```sql
-- Analyze table statistics
ANALYZE TABLE users;

-- Optimize table (MySQL)
OPTIMIZE TABLE users;
```

### 7. **Use Prepared Statements**
Protects against SQL injection and improves performance.

### 8. **Monitor Slow Queries**
- Enable slow query logging
- Use EXPLAIN ANALYZE to understand query execution

---

## Resources

### Official Documentation
- **MySQL**: https://dev.mysql.com/doc/
- **PostgreSQL**: https://www.postgresql.org/docs/
- **SQL Server**: https://docs.microsoft.com/en-us/sql/
- **Oracle**: https://docs.oracle.com/
- **SQLite**: https://www.sqlite.org/docs.html

### Learning Platforms
- **W3Schools SQL Tutorial**: https://www.w3schools.com/sql/
- **Mode Analytics SQL Tutorial**: https://mode.com/sql-tutorial/
- **LeetCode SQL**: https://leetcode.com/discuss/interview-question?currentPage=1&orderBy=most_votes&topicTags=sql
- **HackerRank SQL**: https://www.hackerrank.com/domains/sql

### Books
- **"Learning SQL" by Alan Beaulieu**: Beginner-friendly
- **"SQL Performance Explained" by Markus Winand**: Performance optimization
- **"Advanced SQL" by Joe Celko**: Complex queries and design patterns
- **"SQL Antipatterns" by Bill Karwin**: What NOT to do

### Tools
- **DBeaver**: Universal database IDE
- **Adminer**: Web-based database management
- **DataGrip**: JetBrains SQL IDE
- **MySQL Workbench**: MySQL-specific tool
- **pgAdmin**: PostgreSQL management

---

## Contributing

Feel free to add more SQL examples, tips, and best practices to this library!

---

**Version**: 1.0  
**Last Updated**: December 2025  
**Maintainer**: Shamil Suraweera  
**License**: Free to use and modify
