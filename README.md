#  Vrinda Retail Sales Data Analysis - SQL

This project leverages **SQL** to analyze and visualize Retail Sales data . It aims to uncover key insights related to **SSales Analysis, Customer Analysis, Product & Category Performance, Order Status Analysis**,**Shipping & Geographic Insights** ,**Customer Behavior Patterns**,**SKU-Level Analysis**,**Business Insights**and **SChannel Performance** to support informed decision-making for buyers, sellers, and market analysts.

## 📦 Dataset Overview
- Total Records: ~31048 sales transactions
- File Format: CSV (e.g., vrinda_store_cleaned.csv)
- Main Features:

      - Order details (ID, date, quantity, amount)
      - Customer information (ID, gender, location)
      - Product details (SKU, category, size)
      - Shipping details (city, state, postal code)
      - Channel & promotion info (Online/B2B, discounts)

## 🎯 Objectives
- Analyze customer behavior and segmentation
- Identify sales trends across time, product, and geography
- Understand the impact of promotions and discounts
- Evaluate shipping performance and product returns
- Generate business questions and solve them with SQL

## 🛠️ Tools & Technologies
- Microsoft SQL Server (T-SQL)
- SSMS (SQL Server Management Studio)

## 📈 Key Business Questions Solved with SQL
- What is the total revenue generated?
- What are the monthly and yearly sales trends?
- Which product categories contribute most to revenue?
- Who are the top 10 high-value customers?
- What are the top-performing cities and states?
- How do online vs B2B sales compare?
- What is the average order value (AOV)?
- How do discounts affect sales volume and revenue?
- What are the busiest days and months for orders?
- Which customers are repeat buyers vs one-time buyers?


## 📊 Data Model Schema
CREATE TABLE vrinda_sales (
    order_id            VARCHAR(50)      NOT NULL,
    cust_id             VARCHAR(50)      NOT NULL,
    gender              VARCHAR(10),      
    age                 INT,             
    date                DATE,             
    status              VARCHAR(20),      
    channel             VARCHAR(20),    
    sku                 VARCHAR(50),      
    category            VARCHAR(100),     
    size                VARCHAR(10),      
    qty                 FLOAT,           
    currency            VARCHAR(10),      
    amount              FLOAT,                    
    ship_city           VARCHAR(100),     
    ship_state          VARCHAR(100),     
    ship_postal_code    VARCHAR(20),      
    ship_country        VARCHAR(100),     
    b2b                 VARCHAR(5),       
    CONSTRAINT pk_order PRIMARY KEY (order_id, sku)
);
📌 Key Insights & Recommendations
Sales peak during festival seasons and weekends.

80% of revenue comes from 20% of products (Pareto insight).

Repeat buyers spend significantly more than new customers.

Products with high discounts tend to have higher return rates.

Shipping performance varies significantly by region.

For full conclusions, see the /insights_summary.md or presentation deck.


## 📚 How to Run
- Import the dataset into SQL Server using SSMS or import wizard.
- Run the scripts in /sql_queries/business_questions.sql.
- Analyze the result tables to extract business insights.

## 📊 Key Features

-  1.Total sales, quantity, and AOV
-  2.Category and SKU performance
-  3.Monthly sales trends
-  4.Return rate analysis
-  5.Customer behavior by gender and age group
-  6.Channel-wise performance
-  7.Top states by sales and returns
-  8.Sales, depreciation & mileage trends
-  9.B2B vs B2C breakdown
-  10.Geographic analysis by Indian states
-  11.KPI cards for dynamic metrics



🔸 **Source**: CSV file with ~31048 rows × 22 columns records  
🔸 **Scope**: Covers used retail sales across various Indian states

---

## 📈 Snapshots
![image](https://github.com/user-attachments/assets/94fbb1f6-07dd-40fa-b4ab-7a737791c40e)

![image](https://github.com/user-attachments/assets/9294c330-207d-4261-b55e-87827556e39c)

![image](https://github.com/user-attachments/assets/b9253a55-0154-4c23-b8f1-abcd89e285e3)

![image](https://github.com/user-attachments/assets/92729817-e613-4c05-b6f5-e2521bfadaad)

![image](https://github.com/user-attachments/assets/ee752a66-04cf-4806-991f-94fc94e1d414)






---

<!-- ## Conclusion

The project was successful in answering the set of questions about the store's business performance. The results of the project can be used by the store to make decisions about its marketing and product offerings.
