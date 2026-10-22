# 🏥 Clinic Management System Database

**Course:** CIT 406 - Database Design (Fall "A" 2026)  
**Presenters:** Nishant Bhujel & Diben Dangol  
**Instructor:** Professor Anshu Sharma  
**Institution:** Atlantis University

## Project Overview
This repository contains the complete database schema, seed data, logic layer, indexes, and security policies for our Clinic Management System. The database is designed to handle patients, doctors, departments, appointments, medical records, services, and payments, all normalized to Boyce-Codd Normal Form (BCNF).

## Repository Structure
- `schema.sql`: Creates all 10 tables with primary keys, foreign keys, and constraints.
- `seed.sql`: Populates the database with realistic test data (doctors, patients, appointments).
- `cit406/setup.sql`: Contains the advanced logic layer (Views, Functions, Audit Triggers, and Row Level Security policies).
- `docs/data_dictionary.md`: A detailed dictionary describing every table and column.
- `docs/ER_Diagram.md`: The Entity Relationship Diagram matching the built schema.

## How to Rebuild the Database from Scratch

Follow these exact steps to recreate the database on any machine. 

### Prerequisites
- PostgreSQL 15+ installed
- `psql` command-line tool (or a SQL client like pgAdmin/DBeaver)

### Step 1: Create the Database
Open your terminal and run:
```sql
CREATE DATABASE clinic_db;
