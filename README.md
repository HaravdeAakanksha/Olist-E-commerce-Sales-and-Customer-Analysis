# Olist E-commerce Sales and Customer Analysis Using SQL

## Project Overview

This project analyses e-commerce sales and customer behaviour using the Olist dataset. The goal is to understand sales performance, identify high-revenue products and customers, analyse repeat purchases, and compare revenue across customer states.

Using SQL Server, I performed data quality checks and business analysis to find patterns in sales and customer purchasing behaviour.

## Business Objectives

- Analyse monthly sales revenue and changes over time.
- Identify the highest-revenue customers.
- Analyse one-time and repeat customers.
- Calculate Average Order Value (AOV).
- Identify top- and bottom-performing products.
- Compare revenue across product categories.
- Analyse revenue by customer state.
- Rank the top customers in each state.
- Provide recommendations based on the findings.

## Tools and Technologies

- **SQL Server** — Data analysis and querying
- **SQL Server Management Studio (SSMS)** — Writing and executing SQL queries
- **SQL** — Joins, aggregate functions, CTEs, `CASE`, `LAG()`, `DENSE_RANK()`, and window functions

## Dataset

The project uses the Olist Brazilian e-commerce dataset, which contains information about customers, orders, order items, products, sellers, payments, and reviews.

Key tables used:

| Table | Purpose |
|---|---|
| Customers | Customer IDs and locations |
| Orders | Order dates and statuses |
| Order Items | Product prices and quantities |
| Products | Product details and categories |
| Product Category Translation | English category names |
| Payments | Payment records |
| Sellers | Seller information |
| Reviews | Customer review records |

## Project Workflow

### 1. Data Understanding and Quality Checks
- Checked table sizes, missing values, and distinct identifiers.
- Reviewed order statuses and date ranges.
- Checked relationships between orders, customers, and order items.
- Identified missing product categories and an order without a matching payment record.

### 2. Sales Analysis
- Calculated monthly product revenue.
- Compared revenue across months.
- Calculated Average Order Value (AOV).
- Identified the highest-revenue customers.

### 3. Product Analysis
- Ranked products by revenue.
- Identified top- and bottom-performing products.
- Compared revenue across product categories.

### 4. Customer Analysis
- Identified one-time and repeat customers.
- Examined customer purchase frequency.
- Ranked the highest-revenue customers within each state.

### 5. Regional Analysis
- Compared revenue across customer states.
- Identified the states contributing the most product revenue.

## Key Findings

- **Monthly Sales:** November 2017 generated approximately R$987,765 in product revenue.
- **Top Customer:** The highest-revenue customer contributed approximately R$13,440.
- **Repeat Purchases:** Around 3% of customers with delivered orders made more than one delivered purchase during the observed period.
- **Top Product:** The highest-revenue product generated approximately R$63,560.
- **Top Category:** Beauty & Health generated approximately R$1.23 million in product revenue.
- **Top State:** São Paulo generated approximately R$5.07 million in product revenue.

## Business Recommendations

- Explore ways to encourage repeat purchases through loyalty offers and relevant product recommendations.
- Monitor stock and demand for high-revenue product categories.
- Study high-value customers to better understand their purchasing behaviour.
- Review low-revenue products alongside sales quantities and demand before making inventory decisions.
- Monitor monthly revenue and order counts to understand changes in sales performance.

## Limitations

- The analysis focuses on delivered orders.
- Product revenue is calculated from item prices and excludes freight charges and business costs.
- Some product categories are missing or lack English translations.
- Some early months have very few delivered orders.
- The dataset covers a limited period, so repeat-purchase results may not reflect long-term customer behaviour.

## Conclusion

This project demonstrates how SQL can be used to check data quality, analyse e-commerce sales, understand customer behaviour, and identify business opportunities. The findings highlight the importance of high-performing product categories, regional sales, and customer retention.

## Skills Demonstrated

SQL · Data Cleaning and Validation · Data Analysis · Business Insights · Customer Analysis · Sales Analysis · CTEs · Joins · Aggregate Functions · Window Functions
