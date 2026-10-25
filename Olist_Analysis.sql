/*
=========================================================
PROJECT: Olist E-commerce Sales and Customer Analysis 
         Using SQL
=========================================================

DATA SOURCE:
Kaggle - Brazilian E-Commerce Public Dataset by Olist

TOOLS USED:
SQL Server, SQL Server Management Studio (SSMS)

SQL CONCEPTS:
Joins, aggregate functions, GROUP BY, CTEs, CASE, DENSE_RANK(), LAG(), and window functions.

PROJECT OVERVIEW:
This project analyses e-commerce sales and customer behaviour using SQL. Oilist is a platfrom connecting Customers with independent Sellers. It is not simply one online shop selling its own products.

The dataset contains information about customers, orders, products, product categories, payments, sellers, and customer reviews.

The main goal of the project was to understand how the business performs, which products and categories generate the most revenue, where customers are located, and how frequently customers make purchases.

I used SQL to clean and check the data, analyse sales trends, identify important customers, and find business insights that could help improve sales and customer retention.

PROJECT OBJECTIVES

To check the data for missing values and errors.

To find monthly sales revenue.

To identify the top customers.

To understand how many customers purchased more than once.

To calculate the average order value.

To find the best- and lowest-revenue products.

To compare sales across product categories.

To find which states generated the most revenue.

To find the top three customers in each state.

Data Quality Checks

Before analysing the data, I checked the tables for missing values, duplicate records, and incorrect or unmatched data.

I found 99,441 customer records and 99,441 order records. The customer data contained 96,096 unique customers.

I also found some missing product categories and one delivered order that had no matching payment record. I documented these issues and continued with the analysis.

PROJECT GOAL:
To understand sales patterns, identify low-performing
products, and suggest ways to improve business performance.

-----------------------------------------------------------
*/

CREATE DATABASE Olist_Analysis;

USE Olist_Analysis;


----------------------------------------------
-- DATA QUALITY CHECKS
----------------------------------------------


-- CHECK CUSTOMERS
---------------------------------------------------------------------
SELECT TOP 10 * 
FROM olist_customers_dataset; 

SELECT COUNT(*) AS [Total_Customers]
FROM olist_customers_dataset; 

SELECT COUNT(customer_id) 
FROM olist_customers_dataset;

SELECT COUNT(DISTINCT customer_id) AS Unique_CustomersID 
FROM olist_customers_dataset;

SELECT COUNT(customer_unique_id) AS Unique_Customers_UniqueID 
FROM olist_customers_dataset;

SELECT COUNT(DISTINCT customer_unique_id) AS Unique_Customers_UniqueID 
FROM olist_customers_dataset;


-- CHECK ORDERS
---------------------------------------------------------------------
SELECT TOP 10 * 
FROM olist_orders_dataset; 

SELECT COUNT(*) AS [Total_Orders] 
FROM olist_orders_dataset; 

SELECT COUNT(DISTINCT order_id) AS Unique_OrderID 
FROM olist_orders_dataset; 

SELECT COUNT(DISTINCT order_purchase_timestamp) AS [Unique_Orders_Dates] 
FROM olist_orders_dataset; 



-- CHECK ORDER_ITEMS
---------------------------------------------------------------------
SELECT TOP 10 * 
FROM olist_order_items_dataset;

SELECT COUNT(*) AS [Total_Orders_Items] 
FROM olist_order_items_dataset; 

SELECT COUNT(DISTINCT order_id) AS Unique_Order_ID 
FROM olist_order_items_dataset;

SELECT COUNT(DISTINCT order_item_id) Unique_Order_ItemsID
FROM olist_order_items_dataset;

SELECT COUNT(*)
FROM (
SELECT DISTINCT order_item_id, order_id
FROM olist_order_items_dataset
) AS [UniqueOrders];


-- CHECK PAYMENT
---------------------------------------------------------------------
SELECT TOP 10 * 
FROM olist_order_payments_dataset;

SELECT COUNT(*) AS [Total_Payments]
FROM olist_order_payments_dataset;

SELECT COUNT(DISTINCT order_id) AS [Unique_Orders]
FROM olist_order_payments_dataset;

SELECT order_id, COUNT(*) AS Payment_Count
FROM olist_order_payments_dataset
GROUP BY order_id
HAVING COUNT(*) >1;


-- CHECK PRODUCTS
---------------------------------------------------------------------  
SELECT TOP 10 * 
FROM olist_products_dataset;

SELECT COUNT(*) AS [Total_Products]
FROM olist_products_dataset;

SELECT COUNT(DISTINCT product_id) AS [Unique_Products]
FROM olist_products_dataset;



-- SELLERS
---------------------------------------------------------------------		
SELECT TOP 10 * 
FROM olist_sellers_dataset;

SELECT COUNT(*) AS [Total_Sellers]
FROM olist_sellers_dataset;

SELECT COUNT(DISTINCT seller_id) AS [Unique_SellersID]
FROM olist_sellers_dataset;


-- CHECK REVIEWS
---------------------------------------------------------------------
SELECT TOP 10 *
FROM olist_order_reviews_dataset;

SELECT COUNT(*) AS [Total_Reviews]
FROM olist_order_reviews_dataset;

SELECT COUNT(DISTINCT review_id) AS [Unique_ReviewID]
FROM olist_order_reviews_dataset;

SELECT COUNT(DISTINCT order_id) AS [Unique_Reviews_OrderID]
FROM olist_order_reviews_dataset;

SELECT order_id, COUNT(*) AS Review_Count
FROM olist_order_reviews_dataset
GROUP BY order_id
HAVING COUNT(*) > 1;


-- CHECK CATEGORIES TRANSLATION
---------------------------------------------------------------------
SELECT TOP 10 *
FROM product_category_name_translation;

SELECT *
FROM product_category_name_translation
WHERE product_category_name = 'product_category_name';

DELETE 
FROM product_category_name_translation
WHERE product_category_name = 'product_category_name'
 AND product_category_name_english = 'product_category_name_english';

SELECT COUNT(*) AS [Total_Translations]
FROM product_category_name_translation;

SELECT COUNT(DISTINCT product_category_name) AS [Unique_Categories]
FROM product_category_name_translation;

GO
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;



-- CHECK NULL FOR PRODUCT CATEGORIES 
---------------------------------------------------------------------
SELECT COUNT (*) AS [Missing_Categories] 
FROM olist_products_dataset
WHERE product_category_name IS NULL;



-- CHECK PRODUCT CATEGORIES THAT ARE MISSING ENGLISH TRANSLATIONS.
---------------------------------------------------------------------	
SELECT COUNT (*) AS [Missing_Transalation]
FROM olist_products_dataset AS P
LEFT JOIN product_category_name_translation AS T 
ON P.product_category_name = T.product_category_name
WHERE T.product_category_name_english IS NULL
AND P.product_category_name IS NOT NULL



-- COUNT DISTINCT PRODUCT CATEGORY NAMES INSTEAD OF COUNTING ALL MATCHING PRODUCT ROWS.
---------------------------------------------------------------------
SELECT DISTINCT P.product_category_name AS [Missing_Translations]
FROM olist_products_dataset AS P
LEFT JOIN product_category_name_translation AS T 
	ON P.product_category_name = T.product_category_name
WHERE T.product_category_name_english IS NULL
	AND P.product_category_name IS NOT NULL;



-- HOW MANY PRODUCTS BELONG TO EACH CATEGORY.
---------------------------------------------------------------------
SELECT P.product_category_name, COUNT (P.product_category_name) AS [Product_in]
FROM olist_products_dataset AS P
LEFT JOIN product_category_name_translation AS T 
	ON P.product_category_name = T.product_category_name
WHERE T.product_category_name_english IS NULL
	AND P.product_category_name IS NOT NULL
GROUP BY P.product_category_name;



-- CHECK MISSING Purchase Timestamps
---------------------------------------------------------------------
SELECT COUNT(*) AS [[Missing_Timestamps] 
FROM olist_orders_dataset
WHERE order_purchase_timestamp IS NULL;



-- FIND EACH ORDER STATUS AND COUNT THE ORDERS IN EACH STATUS.
---------------------------------------------------------------------
 SELECT DISTINCT order_status AS [UNIQUE_Order_Status]
 FROM olist_orders_dataset;

 SELECT COUNT(*) AS [Total_Orders], order_status
 FROM olist_orders_dataset
 GROUP BY order_status; 

 SELECT 
 MIN(order_purchase_timestamp) AS [Minimum_Timestamp],
 MAX(order_purchase_timestamp) AS [Maximum_Timestamp]
 FROM olist_orders_dataset;


-- Check missing product IDs in order items
---------------------------------------------------------------------
 SELECT COUNT (*) AS [Missing_ProductsIDs] 
FROM olist_order_items_dataset
WHERE product_id IS NULL;

-- Check missing seller IDs in order items
---------------------------------------------------------------------
SELECT COUNT (*) AS [Missing_SellerID] 
FROM olist_order_items_dataset
WHERE seller_id IS NULL;


-- Check missing product prices
---------------------------------------------------------------------
SELECT COUNT (*) AS [Missing_Price] 
FROM olist_order_items_dataset
WHERE price IS NULL;


-- Check missing payment values
---------------------------------------------------------------------
SELECT COUNT (*) AS [Missing_Payment_Value] 
FROM olist_order_payments_dataset
WHERE payment_value IS NULL;


-- Check missing customer IDs in the customers table
---------------------------------------------------------------------
SELECT COUNT(*) AS [Missing_Customer_IDs]
FROM olist_customers_dataset
WHERE customer_id IS NULL;


-- Check negative or zero product prices
---------------------------------------------------------------------
SELECT COUNT(*) AS [Negative_Price]
FROM olist_order_items_dataset
WHERE price <= 0;


-- Check negative or zero product prices
---------------------------------------------------------------------
SELECT COUNT(*) AS [Missing_Orders]
FROM olist_orders_dataset
WHERE order_id is NULL;


-- -- CHECK WHETHER PRODUCT AND SELLER IDS IN ORDER ITEMS EXIST IN THEIR MASTER TABLES.
---------------------------------------------------------------------
SELECT COUNT(*)	AS [Unmatch_PrdoductIDs]
FROM olist_order_items_dataset AS OIds
LEFT JOIN olist_products_dataset AS PIds
ON OIds.product_id = PIds.product_id
WHERE PIds.product_id IS NULL;


-- CHECK WHETHER SELLER IDS IN ORDER ITEMS EXIST IN THE SELLER MASTER TABLE.
---------------------------------------------------------------------
SELECT COUNT(*) AS [Unmatch_SellerIDs]
FROM olist_order_items_dataset AS OIds
LEFT JOIN olist_sellers_dataset AS SIds
ON OIds.seller_id = SIds.seller_id
WHERE SIds.seller_id IS NULL;


-- CHECK ORDER-ITEM AND PAYMENT RELATIONSHIPS.
---------------------------------------------------------------------
SELECT COUNT(*) AS [Unmatch_OrderIDs]
FROM olist_order_items_dataset AS OIds
LEFT JOIN olist_order_payments_dataset as PIds
ON OIds.order_id = PIds.order_id
WHERE PIds.order_id IS NULL;

SELECT COUNT(DISTINCT OIds.order_id) AS [Unmatch_OrderIDs]
FROM olist_order_items_dataset AS OIds
LEFT JOIN olist_order_payments_dataset as PIds
ON OIds.order_id = PIds.order_id
WHERE PIds.order_id IS NULL;

SELECT DISTINCT OIds.order_id AS [Unique_OrderIDs]
FROM olist_order_items_dataset AS OIds
LEFT JOIN olist_order_payments_dataset as PIds
ON OIds.order_id = PIds.order_id
WHERE PIds.order_id IS NULL;


SELECT order_id, order_status
FROM olist_orders_dataset
WHERE order_id = 'bfbd0f9bdef84302105ad712db648a6c';

SELECT *
FROM olist_order_items_dataset
WHERE order_id = 'bfbd0f9bdef84302105ad712db648a6c';

SELECT *
FROM olist_order_payments_dataset
WHERE order_id = 'bfbd0f9bdef84302105ad712db648a6c';

SELECT
    O.order_id,
    O.order_status,
    COUNT(DISTINCT OI.order_item_id) AS Item_Count,
    SUM(OI.price) AS Total_Item_Price,
    COUNT(DISTINCT P.order_id) AS Has_Payment_Record
FROM olist_orders_dataset AS O
JOIN olist_order_items_dataset AS OI
    ON O.order_id = OI.order_id
LEFT JOIN olist_order_payments_dataset AS P
    ON O.order_id = P.order_id
WHERE O.order_id = 'bfbd0f9bdef84302105ad712db648a6c'
GROUP BY O.order_id, O.order_status;

-- **Missing payment record:** One delivered order (`bfbd0f9bdef84302105ad712db648a6c`) contains three order-item rows with a combined item price of approximately 134.97, but has no corresponding record in the payments table. This discrepancy was documented rather than deleting the order, preserving the original data for further analysis.



----------------------------------------------
-- 2. Monthly revenue and growth
----------------------------------------------

-- FIND MONTHLY REVENUE AND TRACK HOW IT CHANGES OVER TIME
---------------------------------------------------------------------
SELECT YEAR(order_purchase_timestamp) AS [Year], 
MONTH(order_purchase_timestamp) AS [Month],
SUM(price) AS [Monthly_Revenue], O.order_status
FROM olist_orders_dataset AS O
JOIN olist_order_items_dataset AS OI 
ON O.order_id = OI.order_id
WHERE O.order_purchase_timestamp IS NOT NULL 
AND O.order_status = 'delivered'
GROUP BY YEAR(order_purchase_timestamp), 
MONTH(order_purchase_timestamp), O.order_status
ORDER BY
    YEAR(O.order_purchase_timestamp),
    MONTH(O.order_purchase_timestamp);


-- Month-over-month revenue growth
---------------------------------------------------------------------
WITH MonthlyRevenue AS (
SELECT 
YEAR (O.order_purchase_timestamp) AS [Year],
MONTH (O.order_purchase_timestamp) AS [Month],
SUM(OI.price) AS [Monthly_Revenue]
FROM olist_orders_dataset AS O
JOIN olist_order_items_dataset AS OI
ON O.order_id = OI.order_id
WHERE O.order_purchase_timestamp IS NOT NULL
AND O.order_status = 'delivered'
GROUP BY
YEAR(O.order_purchase_timestamp),
MONTH(O.order_purchase_timestamp)
),

RevenueChange AS(
SELECT 
[Year],
[Month],
[Monthly_Revenue],
LAG(Monthly_Revenue) OVER (ORDER BY [Year], [Month]) AS Previous_Month_Revenue,
Monthly_Revenue - LAG(Monthly_Revenue) OVER (ORDER BY[Year], [Month]) AS Revenue_Change
FROM MonthlyRevenue
)

SELECT
*,
(Revenue_Change / NULLIF(Previous_Month_Revenue, 0)) * 100.0
AS Revenue_Change_Percentage
FROM RevenueChange
ORDER BY [Year], [Month];



----------------------------------------------
-- 3. Top customers
----------------------------------------------
SELECT TOP 10  C.customer_unique_id, SUM(OI.price) AS [Total_Revenue]
FROM olist_orders_dataset AS O
JOIN olist_order_items_dataset AS OI
ON O.order_id = OI.order_id
JOIN olist_customers_dataset AS C
ON O.customer_id = C.customer_id
WHERE O.order_status = 'delivered'
GROUP BY C.customer_unique_id
ORDER BY SUM(OI.price) DESC;



----------------------------------------------
-- 4. Repeat vs new customers
----------------------------------------------
WITH CustomerOrders AS (
    SELECT 
    customer_unique_id, 
    COUNT(DISTINCT order_id) as Order_Count
    FROM olist_orders_dataset AS O
    JOIN olist_customers_dataset AS C
    ON O.customer_id = C.customer_id
    WHERE O.order_status = 'delivered'
    GROUP BY C.customer_unique_id
)

SELECT 
CASE 
    WHEN Order_Count = 1
    THEN 'New Customers'
    ELSE 'Repeat Customers'
END As [Customers Type],
COUNT(*) AS Customer_Count
FROM CustomerOrders
GROUP BY
    CASE
        WHEN Order_Count = 1 
        THEN 'New Customers'
        ELSE 'Repeat Customers'
    END;


----------------------------------------------
-- 5. Average Order Value (AOV)
----------------------------------------------
SELECT 
YEAR (O.order_purchase_timestamp) AS [Year],
MONTH (O.order_purchase_timestamp) AS [Month],
SUM(OI.price) AS [Total_Revenue],
COUNT(DISTINCT O.order_id) AS [Unique_OrderIDs],
SUM(OI.price) /  COUNT(DISTINCT O.order_id) AS [Average_Order_Value]
FROM olist_orders_dataset AS O
JOIN olist_order_items_dataset AS OI
ON O.order_id = OI.order_id
WHERE O.order_purchase_timestamp IS NOT NULL
AND O.order_status = 'delivered'
GROUP BY
YEAR(O.order_purchase_timestamp),
MONTH(O.order_purchase_timestamp)
ORDER BY
YEAR(O.order_purchase_timestamp),
MONTH(O.order_purchase_timestamp);


----------------------------------------------
-- 6. Top and bottom products
----------------------------------------------
-- TOP 10
SELECT 
TOP 10
 COUNT(DISTINCT O.order_id) AS [Count_Orders],
P.product_id, 
P.product_category_name,
SUM(OI.price) AS [Total_Revenue]
FROM olist_order_items_dataset AS OI
JOIN olist_products_dataset AS P
ON OI.product_id = P.product_id
JOIN olist_orders_dataset AS O
ON OI.order_id = O.order_id
WHERE O.order_status = 'delivered'
GROUP BY P.product_id, P.product_category_name
ORDER BY SUM(OI.price) DESC;

-- BOTTOM 10
SELECT 
TOP 10
 COUNT(DISTINCT O.order_id) AS [Count_Orders],
P.product_id, 
P.product_category_name,
ROUND(SUM(OI.price), 2) AS [Total_Revenue]
FROM olist_order_items_dataset AS OI
JOIN olist_products_dataset AS P
ON OI.product_id = P.product_id
JOIN olist_orders_dataset AS O
ON OI.order_id = O.order_id
WHERE O.order_status = 'delivered'
GROUP BY P.product_id, P.product_category_name
ORDER BY SUM(OI.price);


----------------------------------------------
-- 7. Product category performance
----------------------------------------------
SELECT 
TOP 10
 COUNT(DISTINCT O.order_id) AS [Count_Orders], 
P.product_category_name,
SUM(OI.price) AS [Total_Revenue]
FROM olist_order_items_dataset AS OI
JOIN olist_products_dataset AS P
ON OI.product_id = P.product_id
JOIN olist_orders_dataset AS O
ON OI.order_id = O.order_id
WHERE O.order_status = 'delivered'
GROUP BY P.product_category_name
ORDER BY SUM(OI.price) DESC;



----------------------------------------------
-- 8. Customer purchase frequency
----------------------------------------------
SELECT 
 COUNT(DISTINCT O.order_id) AS [Count_Orders], 
C.customer_unique_id,
SUM(OI.price) AS [Total_Revenue]
FROM olist_order_items_dataset AS OI
JOIN olist_orders_dataset AS O
ON OI.order_id = O.order_id
JOIN olist_customers_dataset AS C 
ON O.customer_id = C.customer_id
WHERE O.order_status = 'delivered'
GROUP BY customer_unique_id
ORDER BY SUM(OI.price) DESC;


----------------------------------------------
-- 9. Revenue by region
----------------------------------------------
SELECT  
C.customer_state,
ROUND(SUM(OI.price), 2) AS Total_Revenue
FROM olist_order_items_dataset AS OI
JOIN olist_orders_dataset AS O
ON OI.order_id = O.order_id
JOIN olist_customers_dataset AS C 
ON O.customer_id = C.customer_id
WHERE O.order_status = 'delivered'
GROUP BY C.customer_state
ORDER BY SUM(OI.price) DESC;


----------------------------------------------
-- 10.Top 3 customers per state
----------------------------------------------
WITH CustomerRevenue AS (
SELECT
C.customer_state,
C.customer_unique_id,
SUM(OI.price) AS Total_Revenue
FROM olist_order_items_dataset AS OI
JOIN olist_orders_dataset AS O
ON OI.order_id = O.order_id
JOIN olist_customers_dataset AS C
ON O.customer_id = C.customer_id
WHERE O.order_status = 'delivered'
GROUP BY
C.customer_state,
C.customer_unique_id
),

RankedCustomers AS (
SELECT *,
DENSE_RANK() OVER (
PARTITION BY customer_state
ORDER BY Total_Revenue DESC) AS Rank_By_State
FROM CustomerRevenue
)

SELECT *
FROM RankedCustomers
WHERE Rank_By_State <= 3
ORDER BY customer_state, Rank_By_State;

/*

KEY FINDINGS

1. **Monthly Sales Revenue:** November 2017 had the highest monthly revenue in the results, at approximately R$987,765.

2. **Top Customers:** The highest-revenue customer contributed approximately R$13,440.

3. **Repeat Customers:** Around 3% of customers with delivered orders made more than one purchase during the period.

4. **Average Order Value:** Monthly AOV varied. December 2016 had an AOV of R$10.90, but it was based on only one order.

5. **Product Performance:** The top product generated approximately R$63,560, while some of the lowest-revenue products earned less than R$4.

6. **Product Categories:** Beauty & Health generated the highest revenue, followed by Watches & Gifts and Bed, Bath & Table.

7. **Purchase Frequency:** The analysis showed how often customers ordered and how much revenue they generated.

8. **Revenue by State:** São Paulo generated the highest revenue, at approximately R$5.07 million.

9. **Top Customers by State:** I used `DENSE_RANK()` to identify the highest-revenue customers in each state.


BUSINESS INSIGHTS AND RECOMMENDATIONS

- **Focus on major markets:** Maintain good service in high-revenue states and explore growth opportunities in other states.
- **Monitor popular categories:** Track demand and stock for the top-performing product categories.
- **Encourage repeat purchases:** Consider loyalty rewards, discounts, and relevant product suggestions.
- **Understand valuable customers:** Study their purchasing patterns to improve customer retention.
- **Review low-revenue products:** Check product demand and sales before deciding whether to promote or remove them.
- **Track monthly performance:** Compare revenue and order counts to understand sales changes.


LIMITATIONS

- The analysis focuses on delivered orders.
- Revenue excludes freight charges and business costs.
- Some product categories were missing or lacked English translations.
- Some early months had very few delivered orders.
- The dataset covers a limited period, so repeat purchases may not reflect long-term behaviour.


CONCLUSION

This project used SQL to analyse sales, products, customers, and regional performance. The results showed that São Paulo generated the highest revenue, Beauty & Health was the top category, and repeat purchases were limited in the available data. These findings helped identify areas where the business could improve sales and customer retention.

*/