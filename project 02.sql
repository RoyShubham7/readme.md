Create database sql_project03;

use sql_project03;

Select * from vrinda_store_cleaned;
--- Rename a table 

EXEC sp_rename 'vrinda_store_cleaned', 'vrinda_sales';

Select * from vrinda_sales;

-- For faster filtering by customer or date
CREATE INDEX idx_customer ON vrinda_sales(cust_id);
CREATE INDEX idx_date ON vrinda_sales(date);





 --Sales Analysis

--Q.1 What is the total sales amount?

SELECT SUM(amount) AS total_sales FROM vrinda_sales;

--Q2.What is the average order value?

SELECT AVG(amount) AS avg_order_value FROM vrinda_sales WHERE qty > 0;

--Q3.What is the total quantity sold?

SELECT SUM(qty) AS total_quantity FROM vrinda_sales WHERE qty > 0;

-Q4.What are the monthly sales trends?

SELECT month_year, SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY month_year
ORDER BY month_year;

--Q5.Which sales channel generates the most revenue?

SELECT channel, SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY channel
ORDER BY total_sales DESC;

-- Customer Analysis
--Q6. How many unique customers are there?

SELECT COUNT(DISTINCT cust_id) AS unique_customers FROM vrinda_sales;

--Q7.What is the gender distribution of customers?

SELECT gender, COUNT(DISTINCT cust_id) AS customer_count
FROM vrinda_sales
GROUP BY gender;

-- Replace M/W with Men/Women
UPDATE vrinda_sales
SET gender = 
    CASE 
        WHEN gender = 'M' THEN 'Men'
        WHEN gender = 'W' THEN 'Women'
        ELSE gender
    END;
--check the gender is update or not
	SELECT gender, 
       CASE 
           WHEN gender = 'M' THEN 'Men'
           WHEN gender = 'W' THEN 'Women'
           ELSE gender 
       END AS updated_gender
FROM vrinda_sales;

--Q8.Who are the top 10 customers by sales?

SELECT Top 10 
cust_id, SUM(amount) AS total_spent
FROM vrinda_sales
GROUP BY cust_id
ORDER BY total_spent DESC;

--Q9.Which age group buys the most?
SELECT
  CASE
    WHEN age < 20 THEN 'Teeneger'
    WHEN age BETWEEN 20 AND 29 THEN 'Youth'
    WHEN age BETWEEN 30 AND 39 THEN 'thirties'
    WHEN age BETWEEN 40 AND 49 THEN 'forties'
    ELSE '50+'
  END AS age_group,
  SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY CASE
    WHEN age < 20 THEN 'Teeneger'
    WHEN age BETWEEN 20 AND 29 THEN 'Youth'
    WHEN age BETWEEN 30 AND 39 THEN 'thirties'
    WHEN age BETWEEN 40 AND 49 THEN 'forties'
    ELSE '50+'
  END 
ORDER BY total_sales DESC;

--Product & Category Performance
---Q10.What are the top 5 selling categories by revenue?

SELECT top 5
   category,
   SUM(amount) AS total_sales
FROM VRINDA_Sales
GROUP BY category
ORDER BY total_sales DESC;

--Q11.Which SKU generated the highest revenue?

SELECT  top 1
     sku,
	 SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY sku
ORDER BY total_sales DESC;

--Q12.Which sizes are the most sold?

SELECT size, SUM(qty) AS total_qty
FROM vrinda_sales
GROUP BY size
ORDER BY total_qty DESC;

-- Order Status Analysis

--Q 13.What is the breakdown of order statuses?

SELECT status, COUNT(*) AS total_orders
FROM vrinda_sales
GROUP BY status;

Q14.What percentage of orders were returned or cancelled?

SELECT
  status,
  Concat(Round(COUNT(*) * 100/ (SELECT COUNT(*) FROM vrinda_sales),2),'%') AS percentage
FROM vrinda_sales
WHERE status IN ('Returned', 'Cancelled')
GROUP BY status;


-- Shipping & Geographic Insights
Q15.Which state has the highest sales volume?

SELECT ship_state, SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY ship_state
ORDER BY total_sales DESC;

--Q16.Top 10 cities by sales?

SELECT  top 10
     ship_city, 
	 SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY ship_city
ORDER BY total_sales DESC;

--- Time Series and Seasonal Trends
--Q17.What are sales by month and category?

SELECT month_name, category, SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY month_name, category
ORDER BY month_name, total_sales DESC;

--Q18.Which month had the highest revenue overall?

SELECT Top 1
     month_name, 
	 SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY month_name
ORDER BY total_sales DESC;

--Q19.Monthly order volume trend

SELECT month_year, COUNT(DISTINCT order_id) AS total_orders
FROM vrinda_sales
GROUP BY month_year
ORDER BY month_year;

--Q20.Is there any monthly pattern in returns?

SELECT month_year, COUNT(*) AS returned_orders
FROM vrinda_sales
WHERE status = 'Returned'
GROUP BY month_year
ORDER BY month_year;


-- Channel Performance
-Q21.Which channel has the highest average order value ?

SELECT channel, AVG(amount) AS avg_order_value
FROM vrinda_sales
GROUP BY channel
ORDER BY avg_order_value DESC;

-Q22.Which channel has the highest return rate?

SELECT channel,
       COUNT(CASE 
	           WHEN status = 'Returned' THEN 1 END) * 100.0 / COUNT(*) AS return_rate
FROM vrinda_sales
GROUP BY channel
ORDER BY return_rate DESC;

-Q23.Which category performs best on Amazon (by revenue)?

SELECT category, SUM(amount) AS total_sales
FROM vrinda_sales
WHERE channel = 'Amazon'
GROUP BY category
ORDER BY total_sales DESC;

-- Customer Behavior Patterns
-Q24.Do men or women spend more on average?

SELECT gender, AVG(amount) AS avg_spent
FROM vrinda_sales
GROUP BY gender;

-Q25.Which age group has the highest order frequency?

SELECT
  CASE
    WHEN age < 20 THEN 'Teeneger'
    WHEN age BETWEEN 20 AND 29 THEN 'Youth'
    WHEN age BETWEEN 30 AND 39 THEN 'thirties'
    WHEN age BETWEEN 40 AND 49 THEN 'forties'
    ELSE '50+'
  END AS age_group,
  COUNT(DISTINCT order_id) AS orders
FROM vrinda_sales
GROUP BY CASE
    WHEN age < 20 THEN 'Teeneger'
    WHEN age BETWEEN 20 AND 29 THEN 'Youth'
    WHEN age BETWEEN 30 AND 39 THEN 'thirties'
    WHEN age BETWEEN 40 AND 49 THEN 'forties'
    ELSE '50+'
  END 
ORDER BY orders DESC;

-Q26.What’s the repeat purchase rate?

SELECT COUNT(cust_id) AS repeat_customers
FROM (
  SELECT cust_id
  FROM vrinda_sales
  GROUP BY cust_id
  HAVING COUNT(DISTINCT order_id) > 1
) AS repeaters;

-- SKU-Level Analysis
--Q27.What are the top 5 most frequently ordered SKUs?

SELECT  
   Top 5
   sku, 
   COUNT(*) AS order_count
FROM vrinda_sales
GROUP BY sku
ORDER BY order_count DESC;

--Q28.Which SKUs are returned the most?

SELECT  Top 5 sku, COUNT(*) AS return_count
FROM vrinda_sales
WHERE status = 'Returned'
GROUP BY sku
ORDER BY return_count DESC;

--Q29.Which SKUs are performing best by revenue per unit?

SELECT Top 10
     sku, 
	 SUM(amount) / NULLIF(SUM(qty), 0) AS revenue_per_unit
FROM vrinda_sales
GROUP BY sku
ORDER BY revenue_per_unit DESC;

--- Operational Metrics
Q30.Total B2B vs B2C revenue split

SELECT b2b, SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY b2b;
--secound method
SELECT 
  CASE 
    WHEN b2b = 1 THEN 'B2B'
    WHEN b2b = 0 THEN 'B2C'
    ELSE 'Unknown'
  END AS customer_type,
  SUM(amount) AS total_sales
FROM vrinda_sales
GROUP BY 
  CASE 
    WHEN b2b = 1 THEN 'B2B'
    WHEN b2b = 0 THEN 'B2C'
    ELSE 'Unknown'
  END;

Q31.B2B orders as % of total

SELECT 
  CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vrinda_sales), 2), '%') AS b2b_order_percentage
FROM vrinda_sales
WHERE b2b = 'TRUE';


Q32.Top 5 states with the highest B2B sales

SELECT 
    Top 5
	ship_state,
	SUM(amount) AS b2b_sales
FROM vrinda_sales
WHERE b2b = 'TRUE'
GROUP BY ship_state
ORDER BY b2b_sales DESC;

---  Profit Leakage (Cancelled/Returned)
--Q33.Loss due to cancellations and returns

SELECT status, SUM(amount) AS lost_revenue
FROM vrinda_sales
WHERE status IN ('Cancelled', 'Returned')
GROUP BY status;

-Q34.Top channels by refund volume

SELECT channel, SUM(amount) AS refund_total
FROM vrinda_sales
WHERE status = 'Refunded'
GROUP BY channel
ORDER BY refund_total DESC;

---Power KPIs
-Q35.Net Sales (excluding refunded/cancelled)

SELECT SUM(amount) AS net_sales
FROM vrinda_sales
WHERE status = 'Delivered';

-Q36.Gross Margin estimate (assume 35% margin)

SELECT SUM(amount) * 0.35 AS estimated_margin
FROM vrinda_sales
WHERE status = 'Delivered';

-- Advanced Business Insights
--Q38.Which product categories have the highest return rate?

SELECT category,
       COUNT(CASE WHEN status = 'Returned' THEN 1 END) * 100.0 / COUNT(*) AS return_rate
FROM vrinda_sales
GROUP BY category
ORDER BY return_rate DESC;

-Q39.Which age group returns the most items?

SELECT
  CASE
    WHEN age < 20 THEN 'Teeneger'
    WHEN age BETWEEN 20 AND 29 THEN 'Youth'
    WHEN age BETWEEN 30 AND 39 THEN 'thirties'
    WHEN age BETWEEN 40 AND 49 THEN 'forties'
    ELSE '50+'
  END AS age_group,
  COUNT(*) AS return_count
FROM vrinda_sales
WHERE status = 'Returned'
GROUP BY
  CASE 
          WHEN age < 20 THEN 'Teeneger'
          WHEN age BETWEEN 20 AND 29 THEN 'Youth'
          WHEN age BETWEEN 30 AND 39 THEN 'thirties'
          WHEN age BETWEEN 40 AND 49 THEN 'forties'
    ELSE '50+'
  END 
ORDER BY return_count DESC;

-Q40.Which states have the highest return volumes?

SELECT ship_state, COUNT(*) AS returns
FROM vrinda_sales
WHERE status = 'Returned'
GROUP BY ship_state
ORDER BY returns DESC;

-Q41.What is the average sales per customer ?

SELECT AVG(total_spent) AS avg_sale_per_customer
FROM (
  SELECT cust_id, SUM(amount) AS total_spent
  FROM vrinda_sales
  GROUP BY cust_id
) AS customer_spending;

-- Product Size Performance
Q42.Which product sizes have highest return rate?

SELECT size,
       COUNT(CASE WHEN status = 'Returned' THEN 1 END) * 100.0 / COUNT(*) AS return_rate
FROM vrinda_sales
GROUP BY size
ORDER BY return_rate DESC;

--Q43.Which sizes sell the most overall?

SELECT size, SUM(qty) AS qty_sold
FROM vrinda_sales
GROUP BY size
ORDER BY qty_sold DESC;

-- Data Quality / Integrity Checks
--Q44.Are there any duplicate orders in the dataset?

SELECT order_id, COUNT(*) AS cnt
FROM vrinda_sales
GROUP BY order_id
HAVING COUNT(*) > 1;

--Q45.How many orders have missing or null data?

SELECT COUNT(*) AS incomplete_rows
FROM vrinda_sales
WHERE order_id IS NULL
   OR cust_id IS NULL
   OR sku IS NULL
   OR amount IS NULL;

---B2B vs B2C Operational Differences
Q46. Which categories are more B2B-focused?

SELECT 
    category,
    COUNT(CASE WHEN b2b = 'TRUE' THEN 1 END) AS b2b_orders,
    COUNT(CASE WHEN b2b = 'FALSE' THEN 1 END) AS b2c_orders
FROM vrinda_sales
GROUP BY category
ORDER BY b2b_orders DESC;

--- Customer Loyalty Potential
-Q47.How many one-time vs repeat buyers?

SELECT
  CASE
    WHEN order_count = 1 THEN 'One-time Buyer'
    ELSE 'Repeat Buyer'
  END AS buyer_type,
  COUNT(*) AS customer_count
FROM (
  SELECT cust_id, COUNT(DISTINCT order_id) AS order_count
  FROM vrinda_sales
  GROUP BY cust_id
) AS sub
GROUP BY
  CASE
    WHEN order_count = 1 THEN 'One-time Buyer'
    ELSE 'Repeat Buyer'
  END
ORDER BY customer_count DESC;

-Q48.What is the percentage of loyal customers?

SELECT COUNT(*) * 100.00 / (
  SELECT COUNT(DISTINCT cust_id)
  FROM vrinda_sales
) AS repeat_customer_percent
FROM (
  SELECT cust_id
  FROM vrinda_sales
  GROUP BY cust_id
  HAVING COUNT(DISTINCT order_id) > 1
) AS repeaters;

-Q49.Revenue, Orders, and Customers (3-in-1 summary)

SELECT
  COUNT(DISTINCT order_id) AS total_orders,
  COUNT(DISTINCT cust_id) AS total_customers,
  SUM(amount) AS total_revenue
FROM vrinda_sales;

-Q50.Which month had the highest number of new customers?

SELECT 
  first_purchase AS month_year,
  COUNT(*) AS new_customers
FROM (
  SELECT 
    cust_id, 
    MIN(month_year) AS first_purchase
  FROM vrinda_sales
  GROUP BY cust_id
) AS first_time
GROUP BY first_purchase
ORDER BY first_purchase ;


