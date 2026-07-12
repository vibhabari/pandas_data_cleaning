# 🚀 Project Sentinel: Real-Time UPI Transaction & Fraud Detection Pipeline

A Data Engineering project built using **Databricks**, **PySpark**, and **Delta Lake** to simulate a UPI transaction processing pipeline using the **Medallion Architecture** (Landing → Bronze → Silver → Gold).

---

## 📌 Project Overview

Project Sentinel demonstrates how raw UPI transaction data can be processed through different stages of a data pipeline to generate business insights and identify suspicious transactions.

Since a real UPI dataset was not available, sample transaction data was generated with Python. The generated data includes common real-world data quality issues such as missing values, duplicate records, invalid amounts, and different timestamp formats.

The pipeline cleans the data, applies simple fraud detection rules, and creates business-ready reports.

> **Note:** The original project specification referred to JSON files. However, this implementation uses **CSV files** throughout the pipeline as instructed by my mentor.

---

## 🛠 Technologies Used

- Databricks
- Apache Spark (PySpark)
- Delta Lake
- Unity Catalog
- Python
- CSV Files

---

## 🏗 Project Architecture

```
Telemetry Generator
        │
        ▼
 Raw CSV Files
        │
        ▼
 Landing Layer
        │
        ▼
 Bronze Layer
        │
        ▼
 Silver Layer
        │
        ▼
 Gold Layer
```

---

## 📂 Project Workflow

### Step 0 – Telemetry Generator

Generates sample UPI transaction data and stores it as CSV files.

The generated data includes:

- Random transaction IDs
- Sender and receiver UPI IDs
- Transaction amount
- Timestamp
- Merchant category
- Transaction status
- IP address
- Device ID

The generator also introduces messy data such as:

- Missing values
- Duplicate rows
- Extra spaces
- Negative amounts
- Different timestamp formats
- Currency symbols in amount values

It also generates suspicious transactions to simulate fraud.

---

### Step 1 – Raw to Landing

Copies the generated CSV files into the Landing layer without making any changes.

This layer acts as a backup of the original data.

---

### Step 2 – Landing to Bronze

Reads the Landing files into Spark and stores them as a Delta table.

At this stage:

- All columns are read as strings.
- No data cleaning is performed.
- Metadata such as ingestion timestamp and source file is added.

---

### Step 3 – Bronze to Silver

This layer performs data cleaning and transformation.

Operations include:

- Removing extra spaces
- Handling missing values
- Cleaning the amount column
- Standardizing timestamps
- Removing invalid records
- Removing duplicate transactions
- Masking sender and receiver UPI IDs

The output is clean and ready for analysis.

---

### Step 4 – Silver to Gold

Creates the final business-ready tables.

The Gold layer performs:

### Business KPI Generation



### Fraud Detection

Transactions are scored using simple rule-based detection.

Rules used:

| Rule | Condition | Score |
|------|-----------|------:|
| High Amount | Amount > ₹100000 | +50 |
| Velocity | 5 or more transactions within 5 minutes | +40 |
| Odd Hour | Transaction between 1 AM–4 AM and Amount > ₹50000 | +20 |

Fraud Severity:

| Score | Severity |
|------:|----------|
| 70+ | HIGH |
| 40–69 | MEDIUM |
| 1–39 | LOW |
| 0 | NONE |

The Gold layer stores:

- Daily KPI Summary
- Fraud Alerts
- All Transactions with Fraud Score

---

## 📊 Output Tables

| Table | Description |
|--------|-------------|
| bronze_upi_transactions | Raw transaction data stored as Delta |
| silver_upi_transactions | Clean and transformed transaction data |
| gold_kpi_daily_summary | Daily business KPIs |
| gold_fraud_alerts | Flagged suspicious transactions |
| gold_transactions_scored | All transactions with fraud score |

---

## 📁 Repository Structure

Project-Sentinel/
│
├── README.md
├── Project_Report.docx
├── screenshots/
│   ├── landing_layer.png
│   ├── bronze_table.png
│   ├── silver_table.png
│   ├── kpi_summary.png
│   ├── flagged_suspicious.png
├── notebooks/
│   ├── project_sentinel.py


---

## ✨ Features

- Synthetic UPI transaction generation
- Medallion Architecture implementation
- Data cleaning and transformation
- Delta Lake tables
- Rule-based fraud detection
- Business KPI generation
- Fraud severity classification
- Fraud alert reporting

---

## 🔮 Future Enhancements

This project can be extended by:

- Processing live transaction data using Spark Structured Streaming
- Applying Machine Learning models for fraud detection
- Sending real-time alerts through Email or Slack
- Creating interactive dashboards using Power BI or Databricks
- Scheduling the pipeline using Databricks Workflows or Azure Data Factory

---

## 📚 Learning Outcomes

Through this project, I learned:

- Medallion Architecture
- Data Engineering workflow
- PySpark DataFrame operations
- Data cleaning techniques
- Rule-based fraud detection
- Business KPI generation
- Working with Unity Catalog in Databricks

---

## 👩‍💻 Author

**Vibha Bari**

Data Engineering Project developed using Databricks and PySpark.