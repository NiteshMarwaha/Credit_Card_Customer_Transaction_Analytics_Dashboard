# DAX Queries — Credit Card Financial Dashboard

All measures/calculated columns below are built in Power BI on top of the `cust_detail` and `cc_detail` tables imported from SQL.

---

## Calculated Columns — `cust_detail`

### AgeGroup
Buckets customers into age bands.

```dax
AgeGroup = SWITCH(
    TRUE(),
    'public cust_detail'[customer_age] < 30, "20-30",
    'public cust_detail'[customer_age] >= 30 && 'public cust_detail'[customer_age] < 40, "30-40",
    'public cust_detail'[customer_age] >= 40 && 'public cust_detail'[customer_age] < 50, "40-50",
    'public cust_detail'[customer_age] >= 50 && 'public cust_detail'[customer_age] < 60, "50-60",
    'public cust_detail'[customer_age] >= 60, "60+",
    "unknown"
)
```

### IncomeGroup
Buckets customer income into Low / Med / High tiers.

```dax
IncomeGroup = SWITCH(
    TRUE(),
    'public cust_detail'[income] < 35000, "Low",
    'public cust_detail'[income] >= 35000 && 'public cust_detail'[income] < 70000, "Med",
    'public cust_detail'[income] >= 70000, "High",
    "unknown"
)
```

---

## Calculated Columns & Measures — `cc_detail`

### week_num2
Derives an absolute week number from the week start date (used for week-over-week comparisons).

```dax
week_num2 = WEEKNUM('public cc_detail'[week_start_date])
```

### Revenue
Total revenue generated per transaction record.

```dax
Revenue = 'public cc_detail'[annual_fees] + 'public cc_detail'[total_trans_amt] + 'public cc_detail'[interest_earned]
```

### Current_week_Revenue
Revenue for the most recent week in the current filter context.

```dax
Current_week_Revenue = CALCULATE(
    SUM('public cc_detail'[Revenue]),
    FILTER(
        ALL('public cc_detail'),
        'public cc_detail'[week_num2] = MAX('public cc_detail'[week_num2])
    )
)
```

### Previous_week_Revenue
Revenue for the week immediately prior to the most recent week — used to calculate week-over-week (WoW) % change.

```dax
Previous_week_Revenue = CALCULATE(
    SUM('public cc_detail'[Revenue]),
    FILTER(
        ALL('public cc_detail'),
        'public cc_detail'[week_num2] = MAX('public cc_detail'[week_num2]) - 1
    )
)
```

### WoW Revenue % Change (suggested measure)
Not shown explicitly in the source slides but implied by the "Revenue increased by 28.8%" insight — a straightforward extension:

```dax
WoW_Revenue_Change_% =
DIVIDE(
    [Current_week_Revenue] - [Previous_week_Revenue],
    [Previous_week_Revenue]
)
```

---

## Suggested Additional Measures

These aren't shown in the source material but are natural companions for a "financial weekly dashboard" and worth adding:

```dax
Activation_Rate =
DIVIDE(
    CALCULATE(COUNTROWS('public cc_detail'), 'public cc_detail'[Activation_30_Days] = 1),
    COUNTROWS('public cc_detail')
)

Delinquent_Rate =
DIVIDE(
    CALCULATE(COUNTROWS('public cc_detail'), 'public cc_detail'[Delinquent_Acc] = 1),
    COUNTROWS('public cc_detail')
)
```
