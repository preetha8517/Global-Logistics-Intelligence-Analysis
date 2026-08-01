# 📦 Supply Chain Analytics using PostgreSQL & Power BI

## Overview

This project presents an end-to-end Supply Chain Analytics solution developed using **PostgreSQL** and **Microsoft Power BI**. The objective was to transform raw transactional data into meaningful business insights by performing data cleaning, validation, database normalization, dimensional modelling, SQL analysis, and interactive dashboard development.

The project demonstrates the complete Business Intelligence workflow, from data preparation to visualization, enabling stakeholders to monitor business performance and support data-driven decision-making.

---

# Project Objectives

* Clean and validated raw supply chain data.
* Design a normalized relational database (3NF).
* Build a Star Schema for analytical reporting.
* Perform business analysis using SQL.
* Develop interactive Power BI dashboards.
* Identify key business insights.
* Provide strategic business recommendations.

---

# Technology Stack

| Technology   | Purpose                                      |
| ------------ | -------------------------------------------- |
| PostgreSQL   | Database Design & SQL Analysis               |
| SQL          | Data Cleaning, Validation & Business Queries |
| Power BI     | Interactive Dashboard Development            |
| DAX          | KPI & Business Measure Calculations          |
| Git & GitHub | Version Control & Project Documentation      |

---

# Dataset Overview

The dataset contains global supply chain transaction records, including customer information, product details, sales transactions, shipping information, and profitability metrics.

### Dataset Features

* Customer Information
* Product Information
* Category Information
* Geographic Information
* Shipping Details
* Sales & Profit
* Delivery Status

> **Note:** All monetary values are represented in **US Dollars (USD)** as provided in the original dataset.

---

# Project Workflow

```text
Raw Dataset
      │
      ▼
Data Cleaning & Validation
      │
      ▼
Database Normalization (3NF)
      │
      ▼
Star Schema Design
      │
      ▼
Business Analysis using SQL
      │
      ▼
Power BI Dashboard Development
      │
      ▼
Business Insights
      │
      ▼
Business Recommendations
```

---

# Database Design

The project follows a two-stage database design approach.

## Stage 1 – Normalized Database (3NF)

The cleaned transactional data was normalized into separate tables to eliminate redundancy and improve data integrity.

### Tables

* Customers
* Products
* Categories
* Markets
* Shipping
* Orders

---

## Stage 2 – Star Schema

For reporting and analytics, the normalized database was transformed into a dimensional model.

### Fact Table

* Fact_Orders

### Dimension Tables

* Dim_Date
* Dim_Customer
* Dim_Product
* Dim_Category
* Dim_Market
* Dim_Shipping

This model improves query performance and supports efficient Power BI reporting.

---

# Power BI Dashboards

The project consists of four interactive dashboards.

## 1. Executive Dashboard

Provides a high-level overview of business performance through key performance indicators.

### KPIs

* Total Sales
* Total Profit
* Total Orders
* Total Customers
* Quantity Sold
* Average Order Value
* Late Delivery Rate

---

## 2. Sales Dashboard

Focuses on sales trends across:

* Markets
* Countries
* Product Categories
* Products
* Yearly Sales
* Quarterly Sales

---

## 3. Shipping Dashboard

Analyzes logistics performance through:

* Shipping Modes
* Delivery Status
* Late Delivery Analysis
* Shipping Profitability

---

## 4. Customer & Product Dashboard

Provides insights into:

* Top Customers
* Customer Sales
* Product Performance
* Category Performance
* Customer Profitability

---

# Key Performance Indicators

| KPI                           | Value              |
| ----------------------------- | ------------------ |
| **Total Sales**               | **$36.78 Million** |
| **Total Profit**              | **$3.97 Million**  |
| **Total Orders**              | **65,752**         |
| **Total Customers**           | **21,000+**        |
| **Total Quantity Sold**       | **384,000 Units**  |
| **Average Order Value (AOV)** | **$559.42**        |
| **Late Delivery Orders**      | **36,000**         |
| **Late Delivery Rate**        | **54.82%**         |

---

# Key Business Insights

* Europe generated the highest sales and profit among all markets.
* LATAM emerged as the second-highest performing market.
* Fishing was the highest-performing product category.
* Standard Class generated the highest sales among shipping modes.
* Field & Stream Sportsman 16 Gun Fire Safe was the top-selling product.
* European sales peaked during Quarter 3.
* Betty (Customer ID: 2641) was identified as the highest-value customer.
* Approximately 54.82% of orders experienced late delivery, highlighting opportunities for logistics improvement.

For detailed analysis, refer to **Business_Insights**.

---

# Business Recommendations

Based on the analytical findings, the following strategic recommendations were proposed:

* Strengthen investment in high-performing markets.
* Improve delivery performance and reduce late shipments.
* Prioritize inventory planning for high-demand categories.
* Expand customer retention initiatives.
* Improve demand forecasting using historical sales trends.
* Enhance data quality through consistent reporting.

Detailed recommendations are available in **Business_Recommendations**.

---

# Project Structure
Supply-Chain-Analytics/
│
├── Dataset/
│
├── SQL/
│   ├── 001_Database_Creation_insertion.sql
│   ├── 002_data_validation.sql
│   ├── 003_Data_cleaned_data_creation_and_insertion.sql
|   ├── 004_cleaned_data_validation.sql
│   ├── 005_Normalization.sql
|   ├── 006_Business_analytics.sql
│   ├── 007_Star_Schema.sql
│   ├── 008_advanced_sql.sql
│
├── PowerBI/
│   ├── Dasboard.pbix
│   
│
├── Documentation/
│   ├── README.md
│   ├── Business_Insights.md
│   ├── Business_Recommendations.md
│
└── LICENSE
```

---

# Skills Demonstrated

* SQL Querying
* Data Cleaning & Validation
* Database Design
* Database Normalization (3NF)
* Dimensional Modelling
* Star Schema Design
* Data Warehousing
* Power BI
* DAX Measures
* Data Visualization
* Business Intelligence
* Dashboard Design
* Business Analytics

---




Developed using **PostgreSQL**, **SQL**, and **Microsoft Power BI** as an end-to-end Business Intelligence solution.
