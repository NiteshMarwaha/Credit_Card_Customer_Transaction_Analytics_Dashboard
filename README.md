# 💳 Credit Card Financial Weekly Dashboard

An end-to-end Power BI project analyzing weekly credit card customer and transaction data, built on top of a SQL database, to deliver a real-time financial performance dashboard for stakeholders.

---

## 📌 Project Objective

To develop a comprehensive credit card **weekly dashboard** that provides real-time insights into key performance metrics and trends, enabling stakeholders to monitor and analyze credit card operations effectively — including revenue, transactions, customer demographics, and risk indicators (activation and delinquency rates).

---

## 🗂️ Dataset

The dataset is split into two entities — **customers** and **credit card transactions** — plus weekly incremental "add" files used to simulate new data arriving each week.

| File | Description | Rows |
|---|---|---|
| `customer.csv` | Base customer demographic & profile data | ~10,108 |
| `credit_card.csv` | Base weekly credit card transaction/account data | ~10,108 |
| `cust_add.csv` | Incremental new customer records (Week 53) | ~185 |
| `cc_add.csv` | Incremental new transaction records (Week 53) | ~185 |

**Time period covered:** Jan 2025 – Dec 2025 (Week 1 – Week 53)

Full schema is documented in [`data/data_dictionary.md`](./data_dictionary.md).

---

## 🛠️ Tools Used

- **SQL** (PostgreSQL) — source of truth tables, data import via CSV
- **Power BI** — data modeling, DAX measures, dashboard/report build
- **Excel** — initial CSV preparation

---

## ⚙️ Workflow

1. **Prepare CSV files** — clean and structure customer & credit card data
2. **Create tables in SQL** and import CSVs (`COPY` / bulk insert)
3. **Connect Power BI to SQL** and build the data model (customer ↔ credit card, joined on `Client_Num`)
4. **Create calculated columns & measures with DAX** — AgeGroup, IncomeGroup, week numbering, Revenue, current/previous week revenue (see [`sql/dax_queries.md`](./dax_queries.md))
5. **Build the dashboard** across report pages
6. **Export & share** the finished report

---

## 📊 Dashboard Pages

### 1. Weekly Status Report (Cover)
Title page framing the report scope: a weekly credit card operations report covering revenue, transactions, and customer trends.

### 2. Credit Card Customer Report
Revenue, Total Interest, Average Income, and Customer Satisfaction Score (CSS) KPIs, filterable by Card Category (Silver/Blue/Gold/Platinum), Channel (Swipe/Online/Chip), Gender, and Quarter. Includes revenue by customer job, revenue trend by week, and breakdowns by marital status, age group, education level, dependents, and top 5 states.

### 3. Credit Card Transaction Report
Revenue, Total Interest, Total Transaction Amount, and Total Transaction Count KPIs, filterable by Card Category, Income Level, and Gender. Includes quarterly revenue & transaction volume trend, revenue by chip-usage channel, expense type, education level, customer job, and card category.

*(Screenshots in `/powerbi/screenshots`)*

---

## 📈 Key Metrics (YTD, as of Week 53 / Dec 31, 2025)

| Metric | Value |
|---|---|
| Overall Revenue | $55.3M |
| Total Interest Earned | $8M |
| Total Transaction Amount | $44.5M |
| Total Transactions | 656K |
| Average Income | $56.98K |
| Customer Satisfaction Score (avg) | 3.19 |
| Overall Activation Rate | 57.5% |
| Overall Delinquent Rate | 6.06% |
| Week-over-Week Revenue Change (Week 53) | +28.8% |

---

## 🔍 Key Insights

- **Blue and Silver cards drive the business** — together contributing ~93% of all transactions and the vast majority of revenue (Blue alone: $46M of $55.3M).
- **Male customers contribute more revenue than female customers** ($31M vs $26M), despite a fairly close customer split by gender (30M vs 25M in the filter counts, which likely represent revenue rather than headcount).
- **Geographic concentration is high** — Texas, New York, and California together account for 68% of revenue.
- **Swipe is the dominant transaction channel by revenue** ($35M), well ahead of Chip ($17M) and Online ($3M) — a notable contrast with the "chip-first" security trend in card payments generally.
- **Businessman and White-collar customer segments generate the most revenue** by job category, while Blue-collar and Retirees contribute the least.
- **Delinquency sits at 6.06%**, worth tracking closely alongside the 57.5% activation rate — a meaningful share of issued cards are not yet activated.
- Revenue **grew 28.8% week-over-week** in the final week of the year (Week 53), suggesting a strong seasonal/year-end spending spike.

---

## 🗃️ DAX Measures Used

Key calculated columns and measures (full list in [`sql/dax_queries.md`](./dax_queries.md)):

- `AgeGroup` — buckets customers into 20-30, 30-40, 40-50, 50-60, 60+
- `IncomeGroup` — buckets income into Low (<35K), Med (35K–70K), High (70K+)
- `week_num2` — derives week number from `week_start_date`
- `Revenue` — `Annual_Fees + Total_Trans_Amt + Interest_Earned`
- `Current_week_Revenue` / `Previous_week_Revenue` — week-over-week comparison measures using `CALCULATE` + `FILTER`

---

## 📁 Repository Structure

```
credit-card-financial-dashboard/
├── README.md
├── data/
│   ├── customer.csv
│   ├── credit_card.csv
│   ├── cust_add.csv
│   ├── cc_add.csv
│   └── data_dictionary.md
├── sql/
│   ├── create_tables.sql
│   └── dax_queries.md
├── powerbi/
│   ├── Credit_Card_Financial_Dashboard.pbix
│   └── screenshots/
│       ├── customer_report.png
│       └── transaction_report.png
└── insights/
    └── key_findings.md
```

---

## 🚀 How to Reproduce

1. Create the SQL database and run [`sql/create_tables.sql`](./create_tables.sql)
2. Import `customer.csv`, `credit_card.csv`, `cust_add.csv`, and `cc_add.csv` into their respective tables
3. Connect Power BI Desktop to the SQL database
4. Apply the DAX measures in [`sql/dax_queries.md`](./dax_queries.md)
5. Build/refresh the report pages

---

## 📬 Contact

Feel free to connect or reach out if you have feedback or questions about this project.
