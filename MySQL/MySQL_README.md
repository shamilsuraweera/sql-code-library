# MySQL Server Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Service Management](#service-management)
4. [Basic Commands](#basic-commands)
5. [User Management](#user-management)
6. [Database Operations](#database-operations)
7. [Common Tips & Best Practices](#common-tips--best-practices)
8. [Troubleshooting](#troubleshooting)

---

## Introduction

**MySQL** is a popular, open-source relational database management system (RDBMS) used to store and retrieve structured data. It's widely used in web applications, data warehouses, and enterprise systems.

### Key Features
- **Reliable & Fast**: ACID compliance and high performance
- **Scalable**: Handles large datasets efficiently
- **Open Source**: Free to use and modify
- **Cross-Platform**: Runs on Linux, macOS, Windows
- **SQL Standard**: Uses standard SQL for querying
- **Window Functions** (MySQL 8.0+): Advanced analytical queries
- **Secure**: User authentication, privilege management, encryption support

### Use Cases
- Web applications (WordPress, Drupal, Joomla, etc.)
- E-commerce platforms (Magento, WooCommerce)
- Data warehousing and business intelligence
- Content management systems
- APIs and backend services

---

## Installation

### On Ubuntu/Debian Linux

#### 1. Update Package Index
```bash
sudo apt update
```

#### 2. Install MySQL Server
```bash
sudo apt install mysql-server -y
```

#### 3. Check Service Status
```bash
sudo systemctl status mysql
```
Expected output: `active (running)`

#### 4. Run Security Script (Recommended)
```bash
sudo mysql_secure_installation
```
Follow the prompts to:
- Choose password validation policy (level 2 recommended)
- Set root password
- Remove anonymous users
- Disable remote root login
- Remove test database
- Reload privilege tables

#### 5. Verify Installation
```bash
mysql --version
```

---

## Service Management

### Check MySQL Status
```bash
sudo systemctl status mysql
```

### Start MySQL Service
```bash
sudo systemctl start mysql
```

### Stop MySQL Service
```bash
sudo systemctl stop mysql
```

### Restart MySQL Service
```bash
sudo systemctl restart mysql
```

### Enable Auto-Start at Boot
```bash
sudo systemctl enable mysql
```
MySQL will start automatically when the system boots.

### Disable Auto-Start at Boot
```bash
sudo systemctl disable mysql
```
MySQL will NOT start automatically on boot. Start manually with `sudo systemctl start mysql`.

### View Service Logs
```bash
sudo journalctl -u mysql -n 50
```
Shows last 50 log entries for MySQL.

---

## Basic Commands

### Connect to MySQL Server

#### As Root User (with password prompt)
```bash
sudo mysql -u root -p
```

#### As Specific User
```bash
mysql -u shamil_suraweera -p -h localhost -P 3306
```
- `-u`: username
- `-p`: prompt for password
- `-h`: host (default: localhost)
- `-P`: port (default: 3306)

#### Without Password (if no password set)
```bash
mysql -u root
```

### Exit MySQL Shell
```sql
EXIT;
```
or
```sql
quit;
```
or press `Ctrl+D`

### Exit Pager (when viewing long output)
Press `q` (for `less` pager)

---

## User Management

### Create a New User
```sql
CREATE USER 'shamil_suraweera'@'localhost' IDENTIFIED BY 'ShamWeer@MySQL0';
```

### Grant All Privileges to User
```sql
GRANT ALL PRIVILEGES ON *.* TO 'shamil_suraweera'@'localhost' WITH GRANT OPTION;
```

### Grant Specific Privileges
```sql
-- Grant SELECT and INSERT on a specific database
GRANT SELECT, INSERT, UPDATE ON mydatabase.* TO 'shamil_suraweera'@'localhost';
```

### Apply Privilege Changes
```sql
FLUSH PRIVILEGES;
```

### View User Privileges
```sql
SHOW GRANTS FOR 'shamil_suraweera'@'localhost';
```

### Change User Password
```sql
ALTER USER 'shamil_suraweera'@'localhost' IDENTIFIED BY 'NewPassword123';
FLUSH PRIVILEGES;
```

### Delete a User
```sql
DROP USER 'shamil_suraweera'@'localhost';
```

### List All Users
```sql
SELECT user, host FROM mysql.user;
```

---

## Database Operations

### Check MySQL Server Version
```sql
SELECT VERSION();
```

### Show Current Database
```sql
SELECT DATABASE();
```

### List All Databases
```sql
SHOW DATABASES;
```

### Create a Database
```sql
CREATE DATABASE mydatabase;
```

### Use/Select a Database
```sql
USE mydatabase;
```

### Show All Tables in Current Database
```sql
SHOW TABLES;
```

### Describe Table Structure
```sql
DESCRIBE table_name;
```
or
```sql
SHOW COLUMNS FROM table_name;
```

### Create a Table
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Insert Data
```sql
INSERT INTO users (first_name, last_name, email) 
VALUES ('Shamil', 'Suraweera', 'shamil@example.com');
```

### Query Data
```sql
SELECT * FROM users;
```

### Update Data
```sql
UPDATE users SET email = 'newemail@example.com' WHERE id = 1;
```

### Delete Data
```sql
DELETE FROM users WHERE id = 1;
```

### Drop a Table
```sql
DROP TABLE users;
```

### Drop a Database
```sql
DROP DATABASE mydatabase;
```

---

## Common Tips & Best Practices

### 1. **Use Strong Passwords**
- Mix uppercase, lowercase, numbers, and special characters
- Minimum 12 characters recommended
- Change passwords regularly

### 2. **Principle of Least Privilege**
- Create users with only necessary permissions
- Don't use root account for everyday operations
- Restrict user access by host (e.g., 'localhost' instead of '%')

### 3. **Regular Backups**
```bash
# Backup a database
mysqldump -u root -p mydatabase > mydatabase_backup.sql

# Backup all databases
mysqldump -u root -p --all-databases > all_databases_backup.sql

# Restore from backup
mysql -u root -p mydatabase < mydatabase_backup.sql
```

### 4. **Use Transactions for Data Integrity**
```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;  -- or ROLLBACK; to undo changes
```

### 5. **Index Important Columns**
```sql
CREATE INDEX idx_email ON users(email);
```
Improves query performance on frequently searched columns.

### 6. **Use Prepared Statements**
Protects against SQL injection attacks (when using application code).

### 7. **Monitor Database Size**
```sql
-- Check database size
SELECT table_schema AS 'Database', 
       ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)'
FROM information_schema.tables
GROUP BY table_schema;
```

### 8. **Check Slow Queries**
Enable slow query log to identify performance bottlenecks.

### 9. **Use UTF-8 for International Characters**
```sql
CREATE DATABASE mydatabase CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 10. **Regular Security Updates**
```bash
sudo apt update
sudo apt upgrade
```

---

## Troubleshooting

### MySQL Service Won't Start
```bash
# Check logs
sudo journalctl -u mysql -n 100

# Try restarting
sudo systemctl restart mysql

# Check port usage (MySQL uses 3306)
sudo netstat -tlnp | grep mysql
```

### Connection Refused
- Ensure MySQL service is running: `sudo systemctl status mysql`
- Check if listening on correct host/port: `sudo netstat -tlnp | grep mysql`
- Verify credentials and host permissions

### Access Denied for User
- Check username and password
- Verify user exists: `SELECT user, host FROM mysql.user;`
- Check user host restrictions (should be 'localhost' for local connections)
- Flush privileges: `FLUSH PRIVILEGES;`

### Lost Root Password
```bash
# Stop MySQL
sudo systemctl stop mysql

# Start with skip-grant-tables (unsafe, use carefully)
sudo mysqld_safe --skip-grant-tables &

# Connect without password
mysql -u root

# Reset password
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'newpassword';
EXIT;

# Restart normally
sudo systemctl restart mysql
```

### Check MySQL Version Compatibility
Window functions (ROW_NUMBER, RANK, etc.) require MySQL 8.0+

```sql
SELECT VERSION();
```

### Port Already in Use
```bash
# Find process using port 3306
sudo lsof -i :3306

# Kill the process if needed
sudo kill -9 <PID>
```

---

## Additional Resources

- **Official MySQL Documentation**: https://dev.mysql.com/doc/
- **MySQL Tutorials**: https://www.w3schools.com/sql/
- **Performance Tuning**: https://dev.mysql.com/doc/refman/8.0/en/optimization.html
- **Security Guide**: https://dev.mysql.com/doc/refman/8.0/en/security.html

---

## Quick Reference Cheat Sheet

| Task | Command |
|------|---------|
| Start MySQL | `sudo systemctl start mysql` |
| Stop MySQL | `sudo systemctl stop mysql` |
| Check Status | `sudo systemctl status mysql` |
| Connect as Root | `sudo mysql -u root -p` |
| Connect as User | `mysql -u username -p` |
| Show Databases | `SHOW DATABASES;` |
| Create Database | `CREATE DATABASE dbname;` |
| Use Database | `USE dbname;` |
| Show Tables | `SHOW TABLES;` |
| Describe Table | `DESCRIBE tablename;` |
| Exit MySQL | `EXIT;` or `Ctrl+D` |
| Backup Database | `mysqldump -u root -p dbname > backup.sql` |
| Restore Database | `mysql -u root -p dbname < backup.sql` |
| Create User | `CREATE USER 'user'@'localhost' IDENTIFIED BY 'pass';` |
| Grant Privileges | `GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost';` |
| Flush Privileges | `FLUSH PRIVILEGES;` |

---

**Last Updated**: December 2025
**MySQL Version**: 8.0+
**Author**: Shamil Suraweera