# PostgreSQL Server Guide (Ubuntu 24.04)

## Introduction
PostgreSQL is a powerful open-source object-relational database system focused on correctness, standards compliance, and reliability. Suitable for development, production, analytics, and enterprise systems.

Key features:
- ACID compliant
- Strong SQL standard support
- MVCC concurrency
- JSON / JSONB
- Advanced indexing
- Extensions (PostGIS, uuid-ossp, etc.)
- Strong authentication model

---

## Installation
sudo apt update
sudo apt install -y postgresql postgresql-contrib
psql --version

Default setup:
- Version: 16.x
- Cluster: 16/main
- Data dir: /var/lib/postgresql/16/main
- Config: /etc/postgresql/16/main/

---

## Service Management (manual control)
sudo systemctl disable postgresql
sudo systemctl start postgresql
sudo systemctl stop postgresql
sudo systemctl restart postgresql
systemctl status postgresql
pg_lsclusters

After reboot, cluster should be DOWN unless started manually.

---

## Connecting to PostgreSQL
Local peer auth (admin only):
sudo -u postgres psql

TCP password auth (tools / VS Code):
psql -h 127.0.0.1 -U postgres -d postgres

Exit psql:
\q

---

## Authentication Model (important)
- PostgreSQL uses roles (not just users)
- Local socket defaults to peer authentication
- GUI tools require TCP + password
- Authentication rules are controlled by pg_hba.conf

Auth config file:
/etc/postgresql/16/main/pg_hba.conf

Recommended local TCP rule (place ABOVE other host rules):
host all all 127.0.0.1/32 scram-sha-256

Reload after change:
sudo systemctl reload postgresql

---

## Set postgres Password (required for tools)
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'ShamWeer@PostgreSQL0';"

Always use:
- Host: 127.0.0.1
- Port: 5432
- Auth: Password
- SSL: Off (local)

---

## User & Role Management
Create dev user:
CREATE USER devuser WITH PASSWORD 'DevPass123!';

Create database:
CREATE DATABASE devdb OWNER devuser;

Grant privileges:
GRANT ALL PRIVILEGES ON DATABASE devdb TO devuser;

List users:
\du

Change password:
ALTER USER devuser WITH PASSWORD 'NewStrongPass!';

Drop user:
DROP USER devuser;

---

## Database Operations
List databases:
\l

Connect database:
\c devdb

List tables:
\dt

Describe table:
\d users

Create table:
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Insert:
INSERT INTO users (first_name, last_name, email)
VALUES ('Shamil', 'Suraweera', 'shamil@example.com');

Query:
SELECT * FROM users;

Update:
UPDATE users SET email='new@example.com' WHERE id=1;

Delete:
DELETE FROM users WHERE id=1;

Drop table:
DROP TABLE users;

Drop database:
DROP DATABASE devdb;

---

## Backup & Restore
Backup single database:
pg_dump devdb > devdb.sql

Backup all databases:
pg_dumpall > full_backup.sql

Restore:
psql devdb < devdb.sql

---

## Best Practices
- Do not use postgres user for daily work
- Always use TCP (127.0.0.1) for tools
- Keep PostgreSQL stopped when not needed
- Use strong passwords
- Use transactions for critical operations
- Add indexes for frequently queried columns
- Separate dev and prod roles
- Backup regularly

---

## Troubleshooting
Password authentication failed:
- Password not set
- Wrong pg_hba.conf rule
- Using socket instead of TCP

Peer authentication failed:
- Using local socket with non-postgres OS user
- Fix by using sudo -u postgres or TCP connection

PostgreSQL not running:
sudo systemctl start postgresql

Check logs:
sudo journalctl -u postgresql -n 100

Port 5432 in use:
sudo lsof -i :5432

---

## Quick Reference
Start DB: sudo systemctl start postgresql  
Stop DB: sudo systemctl stop postgresql  
Disable auto-start: sudo systemctl disable postgresql  
Connect admin: sudo -u postgres psql  
TCP connect: psql -h 127.0.0.1 -U user db  
List DBs: \l  
List users: \du  
List tables: \dt  
Backup: pg_dump db > db.sql  
Restore: psql db < db.sql  

---

Last Updated: January 2026  
PostgreSQL Version: 16.x  
OS: Ubuntu 24.04 LTS  
Author: Shamil Suraweera

