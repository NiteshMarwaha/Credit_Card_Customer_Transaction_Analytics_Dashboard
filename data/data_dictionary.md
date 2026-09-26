# Data Dictionary — Credit Card Financial Dashboard

Two related tables, joined on `Client_Num`.

---

## Table: `cust_detail` (from `customer.csv` / `cust_add.csv`)

| Column | Type | Description |
|---|---|---|
| `Client_Num` | BIGINT (PK) | Unique customer identifier |
| `Customer_Age` | INT | Customer's age in years |
| `Gender` | Text | `M` / `F` |
| `Dependent_Count` | INT | Number of dependents |
| `Education_Level` | Categorical | Graduate, High School, Uneducated, Unknown, Post-Graduate, Doctorate |
| `Marital_Status` | Categorical | Married, Single, Unknown |
| `state_cd` | Text | US state code (e.g. TX, NY, CA) |
| `Zipcode` | Text | Postal code |
| `Car_Owner` | Yes/No | Whether the customer owns a car |
| `House_Owner` | Yes/No | Whether the customer owns a house |
| `Personal_loan` | Yes/No | Whether the customer has a personal loan |
| `contact` | Categorical | Contact method: cellular, unknown |
| `Customer_Job` | Categorical | Businessman, White-collar, Blue-collar, Govt, Selfemployeed, Retirees |
| `Income` | Numeric | Annual income |
| `Cust_Satisfaction_Score` | INT (1–5) | Customer satisfaction score (CSS) |

---

## Table: `cc_detail` (from `credit_card.csv` / `cc_add.csv`)

| Column | Type | Description |
|---|---|---|
| `Client_Num` | BIGINT (FK) | Links to `cust_detail.Client_Num` |
| `Card_Category` | Categorical | Blue, Silver, Gold, Platinum |
| `Annual_Fees` | Numeric | Annual card fee charged |
| `Activation_30_Days` | 0/1 | Whether the card was activated within 30 days |
| `Customer_Acq_Cost` | Numeric | Cost incurred to acquire the customer |
| `Week_Start_Date` | Date | Start date of the reporting week |
| `Week_Num` | Text | Week label (e.g. `Week-1`, `Week-53`) |
| `Qtr` | Text | Quarter (Q1–Q4) |
| `current_year` | INT | Reporting year (2023) |
| `Credit_Limit` | Numeric | Credit limit assigned |
| `Total_Revolving_Bal` | Numeric | Revolving balance carried |
| `Total_Trans_Amt` | Numeric | Total transaction amount for the period |
| `Total_Trans_Ct` / `Total_Trans_Vol`* | INT | Total number of transactions for the period |
| `Avg_Utilization_Ratio` | Numeric (0–1) | Average credit utilization ratio |
| `Use Chip` | Categorical | Swipe, Chip, Online |
| `Exp Type` | Categorical | Bills, Entertainment, Fuel, Grocery, Food, Travel |
| `Interest_Earned` | Numeric | Interest earned on the account |
| `Delinquent_Acc` | 0/1 | Whether the account is delinquent |

\* **Note:** the base file `credit_card.csv` names this column `Total_Trans_Vol`, while the incremental file `cc_add.csv` names the equivalent column `Total_Trans_Ct`. Standardize to one name (recommended: `Total_Trans_Ct`) during import/transformation to avoid a broken data model when the two files are combined.

---

## Derived Fields (created in Power BI via DAX)

| Field | Logic |
|---|---|
| `AgeGroup` | Buckets `Customer_Age` into 20-30, 30-40, 40-50, 50-60, 60+ |
| `IncomeGroup` | Buckets `Income` into Low (<35K), Med (35K–70K), High (70K+) |
| `week_num2` | `WEEKNUM(Week_Start_Date)` — absolute week number |
| `Revenue` | `Annual_Fees + Total_Trans_Amt + Interest_Earned` |
| `Current_week_Revenue` | Revenue for the latest week in context |
| `Previous_week_Revenue` | Revenue for the week prior to the latest week |

See [`dax_queries.md`](./dax_queries.md) for full DAX definitions.

---

## Relationships

- `cust_detail[Client_Num]` (1) → `cc_detail[Client_Num]` (many)
- Each customer can have multiple weekly transaction records in `cc_detail`.
