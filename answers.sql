-- Question 1: Achieving 1NF
-- Transforming ProductDetail table to ensure each row contains only one product per order

-- Assuming original data is stored in a table named ProductDetail
-- We use STRING_SPLIT to separate products into individual rows

SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM 
    ProductDetail
CROSS APPLY 
    STRING_SPLIT(Products, ',');
-- Note: TRIM is used to remove any leading/trailing spaces from product names
-- This query assumes SQL Server. For other databases, use appropriate string-splitting functions.

-- Question 2: Achieving 2NF
-- Removing partial dependency of CustomerName on OrderID

-- Step 1: Create a separate table for Orders (OrderID and CustomerName)
SELECT DISTINCT 
    OrderID,
    CustomerName
INTO 
    Orders
FROM 
    OrderDetails;

-- Step 2: Create a new table for OrderItems (OrderID, Product, Quantity)
SELECT 
    OrderID,
    Product,
    Quantity
INTO 
    OrderItems
FROM 
    OrderDetails;

-- Now, Orders table contains OrderID → CustomerName
-- OrderItems table contains OrderID → Product, Quantity
-- This ensures all non-key attributes fully depend on the entire primary key
