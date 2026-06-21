# 🏥 Public Health Clinic Records System

A structured MySQL database project for managing patient records, appointments, diagnoses, treatments, lab tests, payments, and prescriptions at a public health clinic.


## 📋 Table of Contents

- [Author](#author)
- [Project Overview](#project-overview)
- [Database Structure](#database-structure)
- [Getting Started](#getting-started)
- [Sample Data](#sample-data)
- [SQL Concepts Covered](#sql-concepts-covered)
- [File Descriptions](#file-descriptions)

## Authors

* Sabrina Kandeh
* Ameynor Salma Kamara
* Alfreda Victoria Dumbuya

## Project Overview

This project demonstrates how to design and query a relational database for a public health clinic setting. It covers the full cycle from creating tables and inserting records to performing real-world queries using filtering, sorting, aggregation, and joins.

The project is split into two database schemas:

| Schema | Focus |
|---|---|
| `public_health_clinic` | Patient visits, diagnoses, and treatments |
| `public_health_clinic_db` | Doctors, departments, lab tests, payments, and prescriptions |


## Database Structure

### Schema 1 - `public_health_clinic`

```
Patient
  └── Appointment
        └── Medical_Diagnosis  (renamed from Diagnoses)
              └── Treatment
Health_Worker
  └── Appointment
```

| Table | Description |
|---|---|
| `Patient` | Stores patient personal details |
| `Health_Worker` | Stores doctor and nurse records |
| `Appointment` | Links patients to health workers per visit |
| `Medical_Diagnosis` | Diagnosis made at each appointment |
| `Treatment` | Medicine and cost linked to each diagnosis |


### Schema 2 - `public_health_clinic_db`

```
Departments
  └── Doctors
        └── Appointments
        └── Medical_Records
              └── Prescriptions
        └── Laboratory_Tests  (renamed from lab_test)
Patients
  └── Appointments
  └── Medical_Records
  └── Payments
  └── Laboratory_Tests
```

| Table | Description |
|---|---|
| `departments` | Clinic departments (e.g. Cardiology, Pediatrics) |
| `doctors` | Doctor profiles linked to departments |
| `patients` | Patient registration records |
| `appointments` | Scheduled, completed, or cancelled visits |
| `medical_records` | Diagnosis, symptoms, treatment, and notes per visit |
| `laboratory_tests` | Lab test names and results per patient |
| `payments` | Payment amounts per patient visit |
| `prescriptions` | Medications linked to medical records |


## Getting Started

### Requirements

- MySQL 5.7+ or MariaDB 10.3+
- MySQL Workbench, phpMyAdmin, or any SQL client

### Setup

1. Open your SQL client.
2. Run the first script to create and populate `public_health_clinic`:
   ```sql
   SOURCE public_health_clinic.sql;
   ```
3. Run the second script to create and populate `public_health_clinic_db`:
   ```sql
   SOURCE public_health_clinic_db_restructured.sql;
   ```


## Sample Data

Each database includes **20 records** per table. Data reflects realistic Sierra Leonean clinic scenarios with local names, towns, and health conditions.

**Locations covered:** Freetown, Makeni, Bo, Kenema, Port Loko, Kono, Kabala, Waterloo, Kailahun

**Conditions covered:** Malaria, Typhoid, Hypertension, Tuberculosis, Diabetes, Depression, Fractures, and more.


## SQL Concepts Covered

### Data Definition (DDL)
- `CREATE DATABASE` & `CREATE TABLE`
- `RENAME TABLE`, `ALTER TABLE ... CHANGE` (rename column)
- `ALTER TABLE ... ADD CONSTRAINT` (CHECK constraint)
- `PRIMARY KEY`, `FOREIGN KEY`, `AUTO_INCREMENT`
- `ENUM`, `DECIMAL`, `DATE`, `TEXT`

### Data Manipulation (DML)
- `INSERT INTO` - adding records
- `UPDATE ... SET ... WHERE` - modifying records
- `DELETE FROM ... WHERE` - removing records

### Data Query (DQL)
| Concept | Example Use |
|---|---|
| `SELECT *` | Retrieve all columns |
| `SELECT column` | Retrieve specific columns |
| `WHERE` | Filter by condition |
| `AND` / `OR` | Multiple conditions |
| `BETWEEN` | Range filtering |
| `LIKE` | Pattern matching (`A%`, `%in`, `%town%`) |
| `IN` | Match against a list |
| `IS NULL` / `IS NOT NULL` | Check for missing values |
| `ORDER BY ASC/DESC` | Sort results |
| `LIMIT` | Restrict number of rows returned |

### Aggregate Functions
| Function | Purpose |
|---|---|
| `COUNT(*)` | Total number of records |
| `AVG()` | Average value |
| `SUM()` | Total value |
| `MAX()` | Highest value |
| `MIN()` | Lowest value |
| `GROUP BY` | Group results by category |


## File Descriptions

| File | Description |
|---|---|
| `public_health_clinic.sql` | Full script for Schema 1 - patients, appointments, diagnoses, treatments |
| `public_health_clinic_db_restructured.sql` | Full script for Schema 2 - doctors, departments, lab tests, payments, prescriptions |
| `README.md` | Project documentation |
 
 