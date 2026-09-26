-- ============================================
-- Credit Card Financial Dashboard - SQL Setup
-- Database: credit_card_db
-- ============================================

CREATE DATABASE credit_card_db;

-- ============================================
-- Table: cust_detail
-- Base customer demographic & profile data
-- Source file: customer.csv
-- ============================================
CREATE TABLE cust_detail (
    Client_Num              BIGINT PRIMARY KEY,
    Customer_Age            INT,
    Gender                  VARCHAR(5),
    Dependent_Count         INT,
    Education_Level         VARCHAR(50),
    Marital_Status          VARCHAR(20),
    state_cd                VARCHAR(5),
    Zipcode                 VARCHAR(10),
    Car_Owner                VARCHAR(5),
    House_Owner              VARCHAR(5),
    Personal_loan            VARCHAR(5),
    contact                  VARCHAR(20),
    Customer_Job             VARCHAR(50),
    Income                   NUMERIC(12,2),
    Cust_Satisfaction_Score  INT
);

-- ============================================
-- Table: cc_detail
-- Weekly credit card transaction/account data
-- Source file: credit_card.csv
-- ============================================
CREATE TABLE cc_detail (
    Client_Num              BIGINT REFERENCES cust_detail(Client_Num),
    Card_Category            VARCHAR(20),
    Annual_Fees               NUMERIC(10,2),
    Activation_30_Days        INT,
    Customer_Acq_Cost         NUMERIC(10,2),
    Week_Start_Date           DATE,
    Week_Num                  VARCHAR(10),
    Qtr                        VARCHAR(5),
    current_year               INT,
    Credit_Limit                NUMERIC(12,2),
    Total_Revolving_Bal         NUMERIC(12,2),
    Total_Trans_Amt              NUMERIC(12,2),
    Total_Trans_Ct                INT,
    Avg_Utilization_Ratio          NUMERIC(6,3),
    Use_Chip                       VARCHAR(20),
    Exp_Type                       VARCHAR(30),
    Interest_Earned                 NUMERIC(10,2),
    Delinquent_Acc                   INT
);

-- ============================================
-- Import base data (adjust path as needed)
-- ============================================
COPY cust_detail FROM '/path/to/customer.csv' DELIMITER ',' CSV HEADER;
COPY cc_detail FROM '/path/to/credit_card.csv' DELIMITER ',' CSV HEADER;

-- ============================================
-- Import weekly incremental data (Week 53)
-- ============================================
COPY cust_detail FROM '/path/to/cust_add.csv' DELIMITER ',' CSV HEADER;
COPY cc_detail FROM '/path/to/cc_add.csv' DELIMITER ',' CSV HEADER;

-- ============================================
-- Sanity checks
-- ============================================
SELECT COUNT(*) AS total_customers FROM cust_detail;
SELECT COUNT(*) AS total_transactions FROM cc_detail;
SELECT MIN(Week_Start_Date), MAX(Week_Start_Date) FROM cc_detail;
