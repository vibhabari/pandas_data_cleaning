# 📊 E-Commerce Order Analytics System

## Project Overview

This project is a Python and SQLite based ETL (Extract, Transform, Load) application developed as part of the Intern Mini Project. The system processes raw e-commerce order data, cleans and validates it, stores it in an SQLite database, and generates business reports through a command-line interface.

---

## Project Objectives

* Generate realistic e-commerce datasets.
* Clean and validate raw data.
* Handle common data quality issues.
* Load cleaned data into SQLite.
* Perform SQL-based business analysis.
* Generate daily, weekly, and monthly reports.
* Test edge cases to ensure data reliability.

---

## Technologies Used

* Python
* Pandas
* SQLite3

---

## Dataset

The project uses four CSV files:

* **orders.csv**
* **order_items.csv**
* **products.csv**
* **customers.csv**

These datasets include intentional data issues such as:

* Missing customer IDs
* Invalid date formats
* Negative quantities
* Invalid email addresses
* Extra spaces and mixed-case product names

---

## Project Workflow

```text
Generate Sample Data
        │
        ▼
Load CSV Files
        │
        ▼
Data Cleaning
        │
        ▼
Load into SQLite
        │
        ▼
SQL Analysis
        │
        ▼
Generate Reports (CLI)
        │
        ▼
Edge Case Handling
```

---




## Project Structure

```

ecommerce-analytics-system/
│── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── orders.csv
│   │   └── order_items.csv
│   └── cleaned/
│       ├── customers_clean.csv
│       ├── products_clean.csv
│       ├── orders_clean.csv
│       └── order_items_clean.csv
│── scripts/
│   ├── generate_data.py
│   ├── clean_data.py
│   └── report_cli.py
│── sql/
│   ├── aggregations.sql
│   ├── window_functions.sql
│   └── cohort_analysis.sql
│── output/
│   └── sample_reports/
│── README.md
```

---
## Learning Outcomes

Through this project, I learned:

* Data generation using Python
* Data cleaning and validation
* Working with SQLite databases
* Writing SQL queries with joins, CTEs, and window functions
* Building a simple ETL pipeline
* Creating a command-line reporting application
* Handling real-world data quality issues

---

## Author

Developed as part of the **Intern Mini Project – E-Commerce Order Analytics System**.
