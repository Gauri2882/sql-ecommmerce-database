# SQL E-Commerce Database Project

**Tools:** SQLite | **Concepts:** Database Design, SQL Queries, Data Analysis

## Project Overview
Designed and implemented a relational database for an e-commerce platform with:
- 5 normalized tables (Products, Categories, Customers, Orders, Payments)
- Primary/Foreign key relationships
- Sample dataset with 4 products, 2 customers, and 3 orders

## Key SQL Queries
```sql
-- Total Sales by Product
SELECT p.product_name, SUM(oi.quantity * oi.price) AS total_sales 
FROM order_items oi 
JOIN products p ON oi.product_id = p.product_id 
GROUP BY p.product_name;

-- Revenue by Category
SELECT cat.category_name, SUM(oi.quantity * oi.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
GROUP BY cat.category_name;

-- Unpaid Orders
SELECT o.order_id, c.customer_name, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'Unpaid';
```
## Business Insights
- Identified Electronics as top category (60% of total revenue)
- Tracked $1,500+ in sales across products  
- Flagged unpaid orders for revenue recovery

## Technical Achievements
- Implemented database normalization  
- Optimized queries with JOINs and GROUP BY  
- Automated sales reporting
