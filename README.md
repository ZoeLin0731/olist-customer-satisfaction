# Olist Customer Satisfaction & Delivery Performance Analysis

This project is an end-to-end **data analytics pipeline** analyzing how delivery performance impacts customer dissatisfaction using the Brazilian Olist e-commerce dataset.

The workflow integrates **Python (EDA & feature engineering)**, **PostgreSQL (data modeling & SQL analytics)**, and **Tableau (business dashboards)**.

---

## 📌 Business Questions

1. How does delivery delay affect customer dissatisfaction (≤ 2-star reviews)?
2. At what delay thresholds does dissatisfaction increase sharply?
3. Which sellers present higher delivery-related risk?
4. Is delivery performance the sole driver of dissatisfaction?

---

## 🧱 Project Structure
olist-customer-satisfaction/
├── data/
│   └── raw/                  # Original CSV files (ignored in Git)
├── notebooks/
│   └── 01_olist_eda_delivery_satisfaction.ipynb
├── sql/
│   ├── 01_views.sql           # Core analytical views
│   ├── 02_kpis.sql            # KPI calculations
│   ├── 03_analysis.sql        # Business analysis queries
│   └── 04_views_tableau.sql   # Tableau-ready views
├── dashboards/
│   ├── 01_customer_satisfaction_delivery.twb
│   ├── 02_seller_risk.twb
│   └── 03_order_level_exploration.twb
├── README.md
└── .gitignore

---

## 🔄 End-to-End Workflow

### 1️⃣ Data Exploration & Feature Engineering (Python)
- Loaded raw Olist CSV files
- Converted datetime fields
- Engineered key metrics:
  - `delivery_delay_days`
  - `is_dissatisfied` (review score ≤ 2)
- Conducted EDA and statistical validation

Notebook:
notebooks/01_olist_eda_delivery_satisfaction.ipynb

---

### 2️⃣ Data Modeling & Analytics (PostgreSQL)
- Loaded cleaned data into PostgreSQL
- Created analytical SQL views:
  - Order-level delivery & review view
  - Delay bucket aggregation
  - Seller-level risk metrics
- Used window functions, filters, and percentile metrics

SQL scripts:
sql/01_views.sql
sql/02_kpis.sql
sql/03_analysis.sql
sql/04_views_tableau.sql

---

### 3️⃣ Business Intelligence (Tableau)
- Connected Tableau **live** to PostgreSQL
- Built dashboards from SQL views (no extracts)
- Dashboards update automatically when SQL views change

Dashboards:
- **Customer Satisfaction vs Delivery Delay**
- **Seller Delivery Risk**
- **Order-Level Exploration**

---

## 📊 Key Insights

- Orders delivered late are **up to 8× more likely** to receive ≤2-star reviews
- Dissatisfaction increases sharply after **5 days late**
- Early delivery does **not** significantly reduce dissatisfaction beyond baseline
- Delivery delay is a **strong but not exclusive** driver — seller behavior and product quality also matter

---

## 🧠 Skills Demonstrated

- Python (pandas, seaborn, EDA)
- SQL (PostgreSQL, views, aggregations, percentiles)
- Data modeling for BI
- Tableau dashboards (live database connection)
- End-to-end analytics workflow design

---

## 📦 Dataset

Brazilian E-Commerce Public Dataset by Olist  
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

Raw data files are excluded from the repository.

---

## 🚀 How to Reproduce

1. Download the Olist dataset from Kaggle
2. Run the Jupyter notebook for EDA
3. Load cleaned tables into PostgreSQL
4. Execute SQL scripts in order (`01` → `04`)
5. Open Tableau workbooks (`.twb`) and connect to PostgreSQL

---

## 👤 Author

Zoe Lin  
Master’s in Analytics  
Focus: Data Analytics, SQL, Business Intelligence
